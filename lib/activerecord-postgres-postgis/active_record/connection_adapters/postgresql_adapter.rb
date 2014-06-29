module ActiveRecord
  module ConnectionAdapters
    extend ActiveRecord::Postgres::Postgis::Utils::Superclasser

    class PostgreSQLAdapter < adapter_superclass
      def prepare_column_options_with_spatial(column, types)
        spec = prepare_column_options_without_spatial(column, types)
        spec[:spatial_type] = column.spatial_type if column.respond_to?(:spatial_type) && column.spatial_type
        spec[:srid] = column.srid.to_s if column.respond_to?(:srid) && column.srid
        spec[:dimension] = column.spatial_type if column.respond_to?(:dimension) && column.dimension
        spec
      end

      alias_method_chain :prepare_column_options, :spatial

      def migration_keys_with_spatial
        migration_keys_without_spatial + [:spatial_type, :srid, :dimension]
      end

      alias_method_chain :migration_keys, :spatial

      def native_database_types_with_spatial
        native_database_types_without_spatial.merge({ geometry: { name: 'geometry' } })
      end

      alias_method_chain :native_database_types, :spatial
    end
  end
end
