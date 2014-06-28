require 'active_support'

if defined?(Rails)
  require 'activerecord-postgres-postgis/railtie'
else
  # TODO require ActiveRecord support
end
