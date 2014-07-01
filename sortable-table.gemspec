# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sortable_table/version'

Gem::Specification.new do |s|
  s.name = 'sortable-table'
  s.version = SortableTable::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Jay Mitchell']
  s.email = ['jaybmitchell@gmail.com']
  s.homepage = 'https://github.com/caselle/sortable-table'
  s.summary = 'Sort HTML table columns'
  s.description = 'Sort HTML table columns in Rails 4 applications.'

  s.licenses = ['MIT']

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', '>= 3.0.0'
  s.add_dependency 'actionpack', '>= 3.0.0'

  s.add_development_dependency 'bundler', '~> 1.5'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'tzinfo-data'
  s.add_development_dependency 'rails'
end