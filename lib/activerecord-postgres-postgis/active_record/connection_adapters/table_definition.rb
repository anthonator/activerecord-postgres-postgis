module ActiveRecord
  module ConnectionAdapters
    class TableDefinition
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
  end
end
