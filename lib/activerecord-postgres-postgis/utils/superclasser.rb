module ActiveRecord
  module Postgres
    module Postgis
      module Utils
        module Superclasser
          def adapter_superclass
            if RUBY_PLATFORM != 'java'
              ActiveRecord::ConnectionAdapters::AbstractAdapter
            else
              ActiveRecord::ConnectionAdapters::JdbcAdapter
            end
          end

          def column_superclass
            if RUBY_PLATFORM != 'java'
              ActiveRecord::ConnectionAdapters::Column
            else
              ActiveRecord::ConnectionAdapters::JdbcColumn
            end
          end
        end
      end
    end
  end
end
