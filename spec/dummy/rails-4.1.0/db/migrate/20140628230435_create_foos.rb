class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.geometry :bar, srid: 423, type: 'LINESTRING', dimension: 2

      t.timestamps
    end
  end
end
