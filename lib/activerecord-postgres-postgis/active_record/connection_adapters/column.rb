module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLColumn < Column
      attr_reader :spatial_type, :srid

      attr_accessor :oid_type

      def initialize_with_spatial(name, default, oid_type, sql_type = nil, null = true)
        initialize_without_spatial(name, default, oid_type, sql_type, null)

        @spatial_type = extract_spatial_type(sql_type)
        @srid = extract_srid(sql_type)

        if spatial?
          oid_type.srid = @srid
        end
      end

      alias_method_chain :initialize, :spatial

      def simplified_type_with_spatial(field_type)
        if field_type =~ /^(?:geometry)/
          :geometry
        elsif field_type =~ /^(?:geography)/
          :geography
        else
          simplified_type_without_spatial(field_type)
        end
      end

      alias_method_chain :simplified_type, :spatial

      def spatial?
        !sql_type.match(/^(geometry|geography)/).nil?
      end

      private
      def extract_spatial_type(sql_type)
        if sql_type =~ /^(geometry|geography)\(([a-z]+)(,\d+)?\)/i
          @limit = nil
          "'#{$2.upcase}'"
        end
      end

      def extract_srid(sql_type)
        if sql_type =~ /^(geometry|geography)\(([a-z]+)(,(\d+))\)/i
          @limit = nil
          $4.to_i
        end
      end
    end
  end
end
