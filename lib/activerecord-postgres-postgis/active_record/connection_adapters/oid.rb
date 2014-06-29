module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      module OID
        class Spatial < Type
          def initialize(factory = nil)
            @factory = factory
          end

          def type_cast(value)
            if value.kind_of?(RGeo::Feature::Geometry)
              RGeo::Feature.cast(value, @factory)
            elsif value && value.respond_to?(:to_s)
              marker = value[0, 1]
              if marker == "\x00" || marker == "\x01" || value[0,4] =~ /[0-9a-fA-F]{4}/
                RGeo::WKRep::WKBParser.new(@factory, support_ewkb: true).parse(value)
              else
                RGeo::WKRep::WKTParser.new(@factory, support_ewkt: true).parse(value)
              end
            else
              nil
            end
          end
        end

        register_type('geometry', Spatial.new)
      end
    end
  end
end
