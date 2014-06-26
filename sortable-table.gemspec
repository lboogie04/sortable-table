# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sortable-table/version'

Gem::Specification.new do |s|
  s.name = 'sortable-table'
  s.version = SortableTable::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Jay Mitchell']
  s.email = ['jbm@caselle.com']
  s.homepage = 'https://github.com/caselle/sortable-table'
  s.summary = 'Sort HTML table columns'
  s.description = 'Sort HTML table columns in Rails 4 applications.'

  s.files         = Dir['./**/*'].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.licenses = ['MIT']

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end