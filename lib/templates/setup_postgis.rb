class SetupPostgis < ActiveRecord::Migration
  def self.up
    execute 'CREATE EXTENSION IF NOT EXISTS postgis'
  end

  def self.down
    execute 'DROP EXTENSION IF EXISTS postgis'
  end
end
