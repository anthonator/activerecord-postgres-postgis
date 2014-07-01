Dir["#{File.dirname(__FILE__)}/**/*.rb"].each { |f| require f }

ActiveRecord::Base.extend(ActiveRecord::Postgres::Postgis::Model)
