namespace :postgis do
  desc 'Enable the postgis extension'
  task 'enable' do
    ActiveRecord::Base.connection.execute('CREATE EXTENSION IF NOT EXISTS postgis')
  end

  desc 'Disable the postgis extension'
  task 'disable' do
    ActiveRecord::Base.connection.execute('DROP EXTENSION IF EXISTS postgis')
  end
end
Rake::Task['db:schema:load'].ehance(['postgis:enable'])
