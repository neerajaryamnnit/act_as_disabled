module ActAsDisabled

  #sort abbreviation of ActAsDisabled => aad
  def self.included(base)
    base.extend Query
  end

  module Query
    def self.extended(base)
      base.define_callbacks :disable
    end
    def aad_default_scope
      scope = all
      if string_type_with_deleted_value?
        scope.where(aad_column => nil).or(scope.where.not(aad_column => aad_config[:deleted_value]))
      elsif boolean_type_not_nullable?
        scope.where(aad_column => false)
      else
        scope.where(aad_column => nil)
      end
    end

    def without_aad_default_scope
      scope = all
      scope = scope.unscope(where: aad_column)
      # Fix problems with unscope group chain
      scope = scope.unscoped if scope.to_sql.include? aad_default_scope.to_sql
      scope
    end

    # remove remove every thing from the query
    # select * from models

    def with_disabled
      without_aad_default_scope
    end

    def only_disabled
      if string_type_with_deleted_value?
        without_aad_default_scope
            .where(aad_column => aad_config[:deleted_value])
      elsif boolean_type_not_nullable?
        without_aad_default_scope.where(aad_column => true)
      else
        without_aad_default_scope.where.not(aad_column => nil)
      end
    end

    def string_type_with_deleted_value?
      aad_column_type == 'string'.to_sym && !aad_config[:deleted_value].nil?
    end

    def boolean_type_not_nullable?
      aad_column_type == 'boolean'.to_sym && !aad_config[:allow_nulls]
    end

    def aad_column
      aad_config[:column].to_sym
    end
    def aad_column_type
      aad_config[:column_type].to_sym
    end

    def aad_column_reference
      "#{table_name}.#{aad_column}"
    end

    def delete_now_value
      case aad_config[:column_type]
      when "time" then Time.now
      when "boolean" then true
      when "string" then aad_config[:deleted_value]
      else
        raise ArgumentError, "'time', 'boolean' or 'string' expected" \
        " for :column_type option, got #{aad_config[:column_type]}"
      end
    end

  end
end

ActiveSupport.on_load(:active_record) do
  class ActiveRecord::Base
    def self.act_as_disabled(options = {})
      define_model_callbacks :disable

      class_attribute :aad_config
      self.aad_config = {
          column: "disabled",
          column_type: "boolean",
          without_default_scope: false
      }
      if options[:column_type] == "string"
        aad_config.merge!(deleted_value: "deleted")
      end
      aad_config.merge!(allow_nulls: false) if options[:column_type] == "boolean"
      aad_config.merge!(options) #merge user

      unless %w[boolean string].include? aad_config[:column_type]
        raise ArgumentError, "'time', 'boolean' or 'string' expected" \
        " for :column_type option, got #{aad_config[:column_type]}"
      end

      include ActAsDisabled

      unless aad_config[:without_default_scope]
        default_scope { aad_default_scope }
      end

      # before_disable { self.class.notify_observers(:before_disable, self) if self.class.respond_to?(:notify_observers) }
      #
      # after_disable { self.class.notify_observers(:after_disable, self) if self.class.respond_to?(:notify_observers) }
    end
  end
end