module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLColumn < Column
      attr_accessor :srid, :spatial_type, :dimension

      def simplified_type_with_spatial(field_type)
        field_type == 'geometry' ? :geometry : simplified_type_without_spatial(field_type)
      end

      alias_method_chain :simplified_type, :spatial
    end
  end
end
