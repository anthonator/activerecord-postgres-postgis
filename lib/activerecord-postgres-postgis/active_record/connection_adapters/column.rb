module ActiveRecord
  module ConnectionAdapters
    module PostgreSQLColumnMethods
      attr_reader :spatial_type, :srid, :dimension

      def initialize_with_spatial(name, default, oid_type, sql_type = nil, null = true)
        initialize_without_spatial(name, default, oid_type, sql_type, null)

        @spatial_type = extract_spatial_type(sql_type)
        @srid = extract_srid(sql_type)
      end

      def simplified_type_with_spatial(field_type)
        field_type =~ /^(?:geometry)/ ? :geometry : simplified_type_without_spatial(field_type)
      end

      private
      def extract_spatial_type(sql_type)
        if sql_type =~ /^(geometry)\(([a-z]+)(,\d+)?\)/i
          @limit = nil
          "'#{$2.upcase}'"
        end
      end

      def extract_srid(sql_type)
        if sql_type =~ /^(geometry)\(([a-z]+)(,(\d+))\)/i
          @limit = nil
          $4.to_i
        end
      end
    end

    if RUBY_PLATFORM != 'java'
      class PostgreSQLColumn < Column
        include PostgreSQLColumnMethods

        alias_method_chain :initialize, :spatial
        alias_method_chain :simplified_type, :spatial
      end
    else
      class PostgreSQLColumn
        include PostgreSQLColumnMethods
        
        alias_method_chain :initialize, :spatial
        alias_method_chain :simplified_type, :spatial
      end
    end
  end
end
