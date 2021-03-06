module ActiveRecord
  module ConnectionAdapters
    module ColumnMethods
      # Adds geometry type for migrations. So you can add column to a table like:
      #   create_table :locations do |t|
      #     ...
      #     t.geometry :geom, srid: 423, type: 'LINESTRING'
      #     ...
      #   end
      #
      def geometry(name, options = {})
        column(name, :geometry, options)
      end

      # Adds geography type for migrations. So you can add column to a table
      # like:
      #   create_table :locations do |t|
      #     ...
      #     t.geography :geog, type: 'LINESTRING'
      #     ...
      #   end
      #
      def geography(name, options = {})
        column(name, :geography, options)
      end
    end

    class PostgreSQLAdapter::ColumnDefinition < ActiveRecord::ConnectionAdapters::ColumnDefinition
      attr_accessor :spatial_type, :srid
    end

    class PostgreSQLAdapter::TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
      include ColumnMethods

      def column_with_spatial(name, type = nil, options = {})
        column = column_without_spatial(name, type, options)[name]
        column.spatial_type = options[:spatial_type]
        column.srid = options[:srid]
        self
      end

      alias_method_chain :column, :spatial
    end

    class PostgreSQLAdapter::Table < ActiveRecord::ConnectionAdapters::Table
      include ColumnMethods
    end
  end
end
