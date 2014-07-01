RSpec.describe :model do
  context :geometry do
    it 'should expect geometry factory generator' do
      column = Foo.columns_hash['bar']
      expect(column.oid_type.factory_generator.class).to eq(RGeo::Cartesian::Factory)
    end

  end

  context :geography do
    it 'should expect geographic factory generator' do
      column = Foo.columns_hash['car']
      expect(column.oid_type.factory_generator.class).to eq(RGeo::Geographic::Factory)
    end
  end
end
