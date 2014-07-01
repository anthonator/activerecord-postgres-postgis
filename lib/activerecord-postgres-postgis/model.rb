module ActiveRecord
  module Postgres
    module Postgis
      FACTORY_GENERATORS = {
        geometry: {
          preferred: :preferred_factory,
          simple: :simple_factory
        },
        geography: {
          spherical: :spherical_factory,
          simple_mercator: :simple_mercator_factory,
          projected: :projected_factory
        }
      }

      module Model
        def spatial(column_name, factory, options = {})
          column = columns_hash[column_name.to_s]
          return unless column

          column.oid_type.factory_generator = factory_generator_class(column.type).send(FACTORY_GENERATORS[column.type][factory], { srid: column.srid }.merge(options))
        end

        private
        def factory_generator_class(column_type)
          if column_type == :geometry
            RGeo::Cartesian
          elsif column_type == :geography
            RGeo::Geographic
          end
        end
      end
    end
  end
end
