require 'rails'

class Postgis < Rails::Railtie
  # Load the postgis:enable and postgis:disable rake tasks
  rake_tasks do
    load 'tasks/postgis.rake'
  end

  generators do
    require 'generators/postgis/setup_generator'
  end

  initializer 'activerecord-postgres-postgis' do
    ActiveSupport.on_load :active_record do
      require File.expand_path('../../activerecord-postgres-postgis/active_record', __FILE__)
    end
  end
end
