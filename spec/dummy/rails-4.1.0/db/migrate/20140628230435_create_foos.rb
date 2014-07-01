class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.geometry :bar, spatial_type: 'LINESTRING', srid: 423
      t.geography :car, spatial_type: 'LINESTRING'

      t.timestamps
    end
  end
end
