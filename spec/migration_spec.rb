RSpec.describe :migration do
  context 'geometry' do
    it 'should render a geometry column with spatial type LINESTRING and srid 423' do
      create_temp_table(:geometry, :geom, spatial_type: 'LINESTRING', srid: 423)
      expect(dump_schema).to match(/t.geometry "geom", spatial_type: 'LINESTRING', srid: 423/)
    end

    it 'should render a geometry column with spatial type LINESTRING and no srid' do
      create_temp_table(:geometry, :geom, spatial_type: 'LINESTRING')
      expect(dump_schema).to match(/t.geometry "geom", spatial_type: 'LINESTRING'/)
    end

    it 'should continue to render other data types' do
      create_temp_table(:integer, :some_integer, limit: 8)
      expect(dump_schema).to match(/t.integer "some_integer", limit: 8/)
    end

    context 'add_geometry_column' do
      it 'should render a geometry column with spatial type LINESTRING and srid 4326' do
        table_name = Time.now.to_i
        ActiveRecord::Migration.create_table(table_name)
        ActiveRecord::Migration.add_geometry_column(table_name, :geom, srid: 4326, spatial_type: 'LINESTRING', dimension: 2)
        expect(dump_schema).to match(/t.geometry "geom", spatial_type: 'LINESTRING', srid: 4326/)
      end
    end
  end

  context 'geography' do
    it 'should render a geography column with spatial type LINESTRING and srid 4326' do
      create_temp_table(:geography, :geog, spatial_type: 'LINESTRING', srid: 4326)
      expect(dump_schema).to match(/t.geography "geog", spatial_type: 'LINESTRING', srid: 4326/)
    end

    it 'should render a geography column with spatial type LINESTRING and srid 4326 even though srid is blank' do
      create_temp_table(:geography, :geog, spatial_type: 'LINESTRING')
      expect(dump_schema).to match(/t.geography "geog", spatial_type: 'LINESTRING', srid: 4326/)
    end
  end
end
