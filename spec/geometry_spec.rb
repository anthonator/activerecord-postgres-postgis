RSpec.describe :geometry do
  it 'should cast WKT to rgeo' do
    foo = Foo.new(geometry_without_options: 'LINESTRING(0 0, 1 1)')
    expect(foo.geometry_without_options).to be_kind_of(RGeo::Feature::Geometry)
  end

  it 'should cast WKB to rgeo' do
    foo = Foo.new(geometry_without_options: '00200000020000000000000002000000000000000000000000000000003ff00000000000003ff0000000000000')
    expect(foo.geometry_without_options).to be_kind_of(RGeo::Feature::Geometry)
  end

  it 'should gracefully handle nil' do
    foo = Foo.new(geometry_without_options: nil)
    expect(foo.geometry_without_options).to be_nil
  end

  it 'should save WKT and cast to rgeo' do
    foo = Foo.new(geometry_without_options: 'LINESTRING(0 0, 1 1)')
    foo.save!
    foo.reload
    expect(foo.geometry_without_options).to be_kind_of(RGeo::Feature::Geometry)
  end

  it 'should save WKB and cast to rgeo' do
    foo = Foo.new(geometry_without_options: '00200000020000000000000002000000000000000000000000000000003ff00000000000003ff0000000000000')
    foo.save!
    foo.reload
    expect(foo.geometry_without_options).to be_kind_of(RGeo::Feature::Geometry)
  end

  context :queries do
    before(:each) do
      @foo = Foo.new(geometry_without_options: 'LINESTRING(0 0, 1 1)')
      @foo.save!
      @foo.reload
    end

    it 'should work with a find_by! query' do
      expect(Foo.find_by!(geometry_without_options: @foo.geometry_without_options).geometry_without_options).to eq(@foo.geometry_without_options)
    end

    it 'should work with a where query' do
      expect(Foo.where(geometry_without_options: @foo.geometry_without_options)[0].geometry_without_options).to eq(@foo.geometry_without_options)
    end
  end
end
