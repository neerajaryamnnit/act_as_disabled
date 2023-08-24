# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'act_as_disabled/version'

Gem::Specification.new do |spec|
  spec.name        = 'act_as_disabled'
  spec.version     = ActAsDisabled::VERSION
  spec.authors     = ['Neeraj Kumar', 'Ashish Jajoria']
  spec.email       = %w[neeraj.kumar@jarvis.consulting akakenterprises@gmail.com]
  spec.summary     = 'Active Record plugin which allows you to disable and enable the record'
  spec.description = 'Active Record plugin which allows you to disable and enable the record'
  spec.homepage    = 'https://github.com/neerajaryamnnit/act_as_disabled'
  spec.license     = 'MIT'

  spec.files         = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  spec.test_files    = Dir['test/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 5.0.7'
  spec.add_dependency 'activesupport', '>= 5.0.7'

  spec.add_development_dependency 'bundler', '>= 1.5'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'rubocop', '~> 0.85.1'
  spec.add_development_dependency 'simplecov', '~> 0.18.1'
end
