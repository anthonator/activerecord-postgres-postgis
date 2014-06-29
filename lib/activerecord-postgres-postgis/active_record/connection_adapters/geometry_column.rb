module ActiveRecord
  module ConnectionAdapters
    if RUBY_PLATFORM != 'java'
      class PostgreSQLColumn < Column
        def simplified_type_with_geometry(field_type)
          field_type == 'geometry' ? :geometry : simplified_type_without_geometry(field_type)
        end

        alias_method_chain :simplified_type, :geometry
      end
    else
      class PostgreSQLColumn
        def simplified_type_with_geometry(field_type)
          field_type == 'geometry' ? :geometry : simplified_type_without_geometry(field_type)
        end

        alias_method_chain :simplified_type, :geometry
      end
    end
  end
end
