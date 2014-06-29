module ActiveRecord
  module ConnectionAdapters
    module SchemaStatements
      # Adds a spatial column to the table using the PostGIS "AddGeometryColumn()"
      # function.
      #
      # This method exists for backwards compatability with PostGIS 1.x.
      #
      # Example:
      #   add_geometry_column :roads, :geom, srid: 423, type: 'LINESTRING', dimension: 2
      #
      def add_geometry_column(table_name, column_name, options = {})
        query_params = "'#{table_name}', '#{column_name}', '#{options[:srid]}', '#{options[:type]}', '#{options[:dimension]}'"
        if options[:schema] || options[:schema_name]
          query_params = "'#{(options[:schema] || options[:schema_name])}'" << query_params
        end
        execute "SELECT AddGeometryColumn(#{query_params})"
      end
    end
  end
end
