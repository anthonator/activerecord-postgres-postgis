class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.geometry :geometry_with_spatial_type_and_srid, spatial_type: 'LINESTRING', srid: 423
      t.geometry :geometry_with_spatial_type, spatial_type: 'LINESTRING'
      t.geometry :geometry_without_options
      t.string   :some_array, array: true

      t.timestamps
    end
  end
end
