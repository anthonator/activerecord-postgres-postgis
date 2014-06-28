require 'generator_spec'
require File.expand_path("../../lib/generators/postgis/setup_generator", __FILE__)

RSpec.describe Postgis::SetupGenerator, type: :generator do
  destination File.expand_path('../../tmp', __FILE__)

  before(:each) do
    prepare_destination
    run_generator
  end

  it 'should create the setup_postgis migration' do
    assert_migration('db/migrate/setup_postgis.rb')
  end

  context 'Rails 4.x' do
    before(:each) do
      stub_const('Rails::VERSION::STRING', '4.1.0')
      prepare_destination
      run_generator
    end

    it 'should enable the postgis extension on up' do
      assert_migration('db/migrate/setup_postgis.rb') do |migration|
        assert_class_method :up, migration do |up|
          assert_match(/enable_extension :postgis/, up)
        end
      end
    end

    it 'should disable the postgis extension on down' do
      assert_migration('db/migrate/setup_postgis.rb') do |migration|
        assert_class_method :down, migration do |down|
          assert_match(/disable_extension :postgis/, down)
        end
      end
    end
  end

  context 'Rails 3.x' do
    before(:each) do
      stub_const('Rails::VERSION::STRING', '3.0.0')
      prepare_destination
      run_generator
    end

    it 'should enable the postgis extension on up' do
      assert_migration('db/migrate/setup_postgis.rb') do |migration|
        assert_class_method :up, migration do |up|
          assert_match(/execute 'CREATE EXTENSION IF NOT EXISTS postgis'/, up)
        end
      end
    end

    it 'should disable the postgis extension on down' do
      assert_migration('db/migrate/setup_postgis.rb') do |migration|
        assert_class_method :down, migration do |down|
          assert_match(/execute 'DROP EXTENSION IF EXISTS postgis'/, down)
        end
      end
    end
  end
end
