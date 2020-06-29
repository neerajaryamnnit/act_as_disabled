# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'act_as_disabled/version'

Gem::Specification.new do |spec|
  spec.name        = 'act_as_disabled'
  spec.version     = ActAsDisabled::VERSION
  spec.authors     = ['Neeraj Kumar']
  spec.email       = ['neeraj.kumar@jarvis.consulting']
  spec.summary     = 'Active Record plugin which allows you to disable and enable the record'
  spec.description = 'Check the home page for more in-depth information.'
  spec.homepage    = 'https://github.com/'
  spec.license     = 'MIT'

  spec.files         = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  spec.test_files    = Dir['test/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 5.0.7', '< 7.0'
  spec.add_dependency 'activesupport', '>= 5.0.7', '< 7.0'

  spec.add_development_dependency 'bundler', '>= 1.5', '< 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'rubocop', '~> 0.85.1'
  spec.add_development_dependency 'simplecov', '~> 0.18.1'
end
