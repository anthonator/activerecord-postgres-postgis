module ActiveRecord
  module ConnectionAdapters
    module ColumnMethods
      # Adds geometry type for migrations. So you can add column to a table like:
      #   create_table :locations do |t|
      #     ...
      #     t.geometry :geom, srid: 423, type: 'LINESTRING', dimension: 2
      #     ...
      #   end
      #
      def geometry(name, options = {})
        column(name, :geometry, options)
      end
    end

    class PostgreSQLAdapter::ColumnDefinition < ActiveRecord::ConnectionAdapters::ColumnDefinition
      attr_accessor :srid, :spatial_type, :dimension
    end

    class PostgreSQLAdapter::TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
      include ColumnMethods

      def column_with_spatial(name, type = nil, options = {})
        column = column_without_spatial(name, type, options)[name]
        column.srid = options[:srid]
        column.spatial_type = options[:type]
        column.dimension = options[:dimension]
        self
      end

      alias_method_chain :column, :spatial
    end

    class PostgreSQLAdapter::Table < ActiveRecord::ConnectionAdapters::Table
      include ColumnMethods
    end
  end
end
