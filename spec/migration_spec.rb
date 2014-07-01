RSpec.describe :migration do
  context 'geometry' do
    it 'should render a geometry column with spatial type LINSTRING and srid 423' do
      schema = StringIO.new

      ActiveRecord::Migration.create_table :test_geometry_column do |t|
        t.geometry :geom, spatial_type: 'LINESTRING', srid: 423
      end

      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, schema, ActiveRecord::Base)

      expect(schema.string).to match(/t.geometry "geom", spatial_type: 'LINESTRING', srid: 423/)
    end

    it 'should render a geometry column with spatial type LINSTRING and no srid' do
      schema = StringIO.new

      ActiveRecord::Migration.create_table :test_geometry_column do |t|
        t.geometry :geom, spatial_type: 'LINESTRING'
      end

      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, schema, ActiveRecord::Base)

      expect(schema.string).to match(/t.geometry "geom", spatial_type: 'LINESTRING'/)
    end
  end

  context 'geography' do
    it 'should render a geography column with spatial type LINSTRING and srid 4326' do
      schema = StringIO.new

      ActiveRecord::Migration.create_table :test_geometry_column do |t|
        t.geography :geog, spatial_type: 'LINESTRING', srid: 4326
      end

      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, schema, ActiveRecord::Base)

      expect(schema.string).to match(/t.geography "geog", spatial_type: 'LINESTRING', srid: 4326/)
    end

    it 'should render a geography column with spatial type LINESTRING and srid 4326 even though srid is blank' do
      schema = StringIO.new

      ActiveRecord::Migration.create_table :test_geometry_column do |t|
        t.geography :geog, spatial_type: 'LINESTRING'
      end

      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, schema, ActiveRecord::Base)

      expect(schema.string).to match(/t.geography "geog", spatial_type: 'LINESTRING', srid: 4326/)
    end
  end
end
