RSpec.describe :geometry do
  it 'should cast WKT to rgeo' do
    foo = Foo.new(bar: 'LINESTRING(0 0, 1 1)')
    expect(foo.bar).to be_kind_of(RGeo::Feature::Geometry)
  end

  it 'should cast WKB to rgeo' do
    foo = Foo.new(bar: '0020000002000001a700000002000000000000000000000000000000003ff00000000000003ff0000000000000')
    expect(foo.bar).to be_kind_of(RGeo::Feature::Geometry)
  end

  it 'should gracefully handle nil' do
    foo = Foo.new(bar: nil)
    expect(foo.bar).to be_nil
  end

  it 'should save WKT and cast to rgeo' do
    foo = Foo.new(bar: 'LINESTRING(0 0, 1 1)')
    foo.save!
    foo.reload
    expect(foo.bar).to be_kind_of(RGeo::Feature::Geometry)
  end

  it 'should save WKB and cast to rgeo' do
    foo = Foo.new(bar: '0020000002000001a700000002000000000000000000000000000000003ff00000000000003ff0000000000000')
    foo.save!
    foo.reload
    expect(foo.bar).to be_kind_of(RGeo::Feature::Geometry)
  end

  context :queries do
    before(:each) do
      @foo = Foo.new(bar: 'LINESTRING(0 0, 1 1)')
      @foo.save!
      @foo.reload
    end

    it 'should work with a find_by! query' do
      expect(Foo.find_by!(bar: @foo.bar).bar).to eq(@foo.bar)
    end

    it 'should work with a where query' do
      expect(Foo.where(bar: @foo.bar)[0].bar).to eq(@foo.bar)
    end
  end
end
