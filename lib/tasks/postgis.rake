namespace :postgis do
  desc 'Enable the postgis extension'
  task 'setup' do
    ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS postgis'
  end
end
Rake::Task['db:schema:load'].ehance(['hstore:setup'])
