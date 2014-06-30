module Arel
  module Visitors
    class ToSql < Arel::Visitors::Visitor
      def visit_RGeo_Feature_Geometry(o, a)
        quote(RGeo::WKRep::WKTGenerator.new(type_format: :ewkt, emit_ewkt_srid: true).generate(o))
      end
    end
  end
end
