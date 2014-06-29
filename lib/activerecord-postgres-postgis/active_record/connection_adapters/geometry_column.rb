module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLColumn < Column
      attr_accessor :srid, :spatial_type, :dimension

      def simplified_type_with_geometry(field_type)
        field_type == 'geometry' ? :geometry : simplified_type_without_geometry(field_type)
      end

      alias_method_chain :simplified_type, :geometry
    end
  end
end
