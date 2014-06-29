module ActiveRecord
  module ConnectionAdapters
    module ColumnMethods
      def self.included(base)
        base.class_eval do
          def simplified_type_with_geometry(field_type)
            field_type == 'geometry' ? :geometry : simplified_type_without_geometry(field_type)
          end

          alias_method_chain :simplified_type, :geometry
        end
      end
    end

    if RUBY_PLATFORM != 'java'
      class PostgreSQLColumn < Column
        include ActiveRecord::ConnectionAdapters::ColumnMethods
      end
    else
      class PostgreSQLColumn
        include ActiveRecord::ConnectionsAdapters::ColumnMethods
      end
    end
  end
end
