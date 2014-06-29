module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLColumn < Column
      attr_reader :spatial_type, :srid, :dimension

      def initialize_with_spatial(name, default, oid_type, sql_type = nil, null = true)
        initialize_without_spatial(name, default, oid_type, sql_type, null)

        @spatial_type = extract_spatial_type(sql_type)
        @srid = extract_srid(sql_type)
      end

      alias_method_chain :initialize, :spatial

      def simplified_type_with_spatial(field_type)
        field_type =~ /^(?:geometry)/ ? :geometry : simplified_type_without_spatial(field_type)
      end

      alias_method_chain :simplified_type, :spatial

      private
      def extract_spatial_type(sql_type)
        $2.upcase if sql_type =~ /^(geometry)\(([a-z]+)(,\d+)?\)/i
      end

      def extract_srid(sql_type)
        $4.to_i if sql_type =~ /^(geometry)\(([a-z]+)(,(\d+))\)/i
      end
    end
  end
end
