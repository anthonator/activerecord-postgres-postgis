require 'rails/generators/migration'

class Postgis::SetupGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), '../../templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    else
      '%.3d' % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    if Rails::VERSION::STRING >= '4.0.0'
      migration_template 'rails4/setup_postgis.rb', 'db/migrate/setup_postgis.rb'
    else
      migration_template 'setup_postgis.rb', 'db/migrate/setup_postgis.rb'
    end
  end
end
