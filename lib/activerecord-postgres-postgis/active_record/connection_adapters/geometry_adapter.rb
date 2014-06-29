module ActiveRecord
  module ConnectionAdapters
    module AdapterMethods
      def self.included(base)
        base.class_eval do
          def native_database_types_with_geometry
            native_database_types_without_geometry.merge({ geometry: { name: 'geometry' } })
          end

          alias_method_chain :native_database_types, :geometry
        end
      end
    end

    if RUBY_PLATFORM != 'java'
      class PostgreSQLAdapter < AbstractAdapter
        include ActiveRecord::ConnectionAdapters::AdapterMethods
      end
    else
      class PostgreSQLAdapter
        include ActiveRecord::ConnectionAdapters::AdapterMethods
      end
    end

    PostgreSQLAdapter.tap do |klass|
      klass::OID.register_type('geometry', klass::OID::Identity.new)
    end
  end
end
