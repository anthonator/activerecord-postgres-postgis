module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      module Quoting
        def type_cast_with_spatial(value, column, array_member = false)
          if value.kind_of?(RGeo::Feature::Geometry)
            RGeo::WKRep::WKBGenerator.new(hex_format: true, type_format: :ewkb, emit_ewkb_srid: true).generate(value)
          else
            type_cast_without_spatial(value, column, array_member)
          end
        end

        alias_method_chain  :type_cast, :spatial
      end
    end
  end
end
