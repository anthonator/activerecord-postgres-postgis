class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.geometry :bar, spatial_type: 'LINESTRING', srid: 423, dimension: 2
      t.string   :some_array, array: true

      t.timestamps
    end
  end
end
