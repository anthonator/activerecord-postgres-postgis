# FIXME This is one of the ugliest pieces of code ever. It performs all the
# necessary tests to meet spec compliance but it's hard on the eyes. Refactor!!!
#
RSpec.describe :spatial do
  [:bar, :car].each do |column|
    it 'should cast WKT to rgeo' do
      foo = Foo.new(:"#{column}" => 'LINESTRING(0 0, 1 1)')
      expect(foo.send(column)).to be_kind_of(RGeo::Feature::Geometry)
    end

    it 'should cast WKB to rgeo' do
      foo = Foo.new(:"#{column}" => '0020000002000001a700000002000000000000000000000000000000003ff00000000000003ff0000000000000')
      expect(foo.send(column)).to be_kind_of(RGeo::Feature::Geometry)
    end

    it 'should gracefully handle nil' do
      foo = Foo.new(:"#{column}" => nil)
      expect(foo.send(column)).to be_nil
    end

    it 'should save WKT and cast to rgeo' do
      foo = Foo.new(:"#{column}" => 'LINESTRING(0 0, 1 1)')
      foo.save!
      foo.reload
      expect(foo.send(column)).to be_kind_of(RGeo::Feature::Geometry)
    end

    it 'should save WKB and cast to rgeo' do
      foo = Foo.new(:"#{column}" => '0020000002000001a700000002000000000000000000000000000000003ff00000000000003ff0000000000000')
      foo.save!
      foo.reload
      expect(foo.send(column)).to be_kind_of(RGeo::Feature::Geometry)
    end

    context :queries do
      before(:each) do
        @foo = Foo.new(:"#{column}" => 'LINESTRING(0 0, 1 1)')
        @foo.save!
        @foo.reload
      end

      it 'should work with a find_by! query' do
        expect(Foo.find_by!(:"#{column}" => @foo.send(column)).send(column)).to eq(@foo.send(column))
      end

      it 'should work with a where query' do
        expect(Foo.where(:"#{column}" => @foo.send(column))[0].send(column)).to eq(@foo.send(column))
      end
    end
  end
end
