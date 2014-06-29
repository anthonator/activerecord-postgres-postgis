module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter::SchemaCreation < ActiveRecord::ConnectionAdapters::AbstractAdapter::SchemaCreation
      def add_column_options_with_spatial!(sql, options)
        column = options.fetch(:column) { return super }
        if column.type == :geometry && column.srid && column.spatial_type
          sql << "(#{column.spatial_type},#{column.srid})"
        else
          add_column_options_without_spatial!(sql, options)
        end
      end

      alias_method_chain :add_column_options!, :spatial
    end

    module SchemaStatements
      # Adds a spatial column to the table using the PostGIS
      # "AddGeometryColumn()" function.
      #
      # This method exists for backwards compatability with PostGIS 1.x.
      #
      # Example:
      #   add_geometry_column :roads, :geom, srid: 423, type: 'LINESTRING', dimension: 2
      #
      def add_geometry_column(table_name, column_name, options = {})
        execute "SELECT AddGeometryColumn('#{table_name}', '#{column_name}', '#{options[:srid]}', '#{options[:type]}', '#{options[:dimension]}')"
      end
    end
  end
end
