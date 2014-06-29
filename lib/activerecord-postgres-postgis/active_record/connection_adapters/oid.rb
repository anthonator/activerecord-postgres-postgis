module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      module OID
        class Spatial < Type
          def type_cast(value)
            value
          end
        end

        register_type('geometry', Spatial.new)
      end
    end
  end
end
