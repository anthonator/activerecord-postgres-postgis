require 'active_support'
require 'rgeo'

if defined?(Rails)
  require 'activerecord-postgres-postgis/railtie'
else
  ActiveSupport.on_load :active_record do
    require File.expand_path('../lib/activerecord-postgres-postgis/active_record', __FILE__)
  end
end
