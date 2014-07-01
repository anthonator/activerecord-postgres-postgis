module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      module OID
        class Spatial < Type
          attr_accessor :factory_generator, :srid

          def initialize(factory_generator = nil)
            @factory_generator = factory_generator
          end

          def type_cast(value)
            if value.kind_of?(RGeo::Feature::Geometry)
              RGeo::Feature.cast(value, @factory)
            elsif value && value.respond_to?(:to_s)
              marker = value[0, 1]
              if marker == "\x00" || marker == "\x01" || value[0,4] =~ /[0-9a-fA-F]{4}/
                RGeo::WKRep::WKBParser.new(@factory_generator, support_ewkb: true, default_srid: srid).parse(value)
              else
                RGeo::WKRep::WKTParser.new(@factory_generator, support_ewkt: true, default_srid: srid).parse(value)
              end
            else
              nil
            end
          end
        end

        register_type('geometry', Spatial.new)
        register_type('geography', Spatial.new(RGeo::Geographic.method(:spherical_factory)))
      end
    end
  end
end
