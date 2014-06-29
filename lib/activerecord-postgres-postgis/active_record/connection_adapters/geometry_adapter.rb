module ActiveRecord
  module ConnectionAdapters
    if RUBY_PLATFORM != 'java'
      class PostgreSQLAdapter < AbstractAdapter
        def native_database_types_with_geometry
          native_database_types_without_geometry.merge({ geometry: { name: 'geometry' } })
        end

        alias_method_chain :native_database_types, :geometry
      end
    else
      class PostgreSQLAdapter
        def native_database_types_with_geometry
          native_database_types_without_geometry.merge({ geometry: { name: 'geometry' } })
        end

        alias_method_chain :native_database_types, :geometry
      end
    end

    PostgreSQLAdapter.tap do |klass|
      klass::OID.register_type('geometry', klass::OID::Identity.new)
    end
  end
end
