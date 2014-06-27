# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord-postgres-postgis/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-postgres-postgis'
  spec.version       = ActiveRecord::Postgres::Postgis::VERSION
  spec.authors       = ['Anthony Smith']
  spec.email         = ['anthony@sticksnleaves.com']
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 3.2'
  spec.add_dependency 'rake'
  spec.add_dependency 'rgeo',         '~> 0.3'

  spec.add_development_dependency 'bundler', '~> 1.6'
end
