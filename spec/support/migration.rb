def create_temp_table(column_type, column_name, options = {})
  ActiveRecord::Migration.create_table Time.now.to_i.to_s.to_sym do |t|
    t.send(column_type, column_name, options)
  end
end

def dump_schema
  stream = StringIO.new
  ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream, ActiveRecord::Base)
  stream.string
end
