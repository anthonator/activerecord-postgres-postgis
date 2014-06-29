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

    class TableDefinition
      include ColumnMethods
    end

    class Table
      include ColumnMethods
    end
  end
end
