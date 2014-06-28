source 'https://rubygems.org'

# Specify your gem's dependencies in activerecord-postgres-postgis.gemspec
gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version
when 'master'
  { github: 'rails/rails' }
when 'default'
  '>= 4.1.0'
else
  "~> #{rails_version}"
end

gem 'rails', rails

platforms :ruby do
  gem 'pg'
end

platforms :jruby do
  gem 'activerecord-jdbcpostgresql-adapter'
end
