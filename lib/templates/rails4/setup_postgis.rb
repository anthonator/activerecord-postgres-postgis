class SetupPostgis < ActiveRecord::Migration
  def self.up
    enable_extension :postgis
  end

  def self.down
    disable_extension :postgis
  end
end
