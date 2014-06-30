# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140628230435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "foos", force: true do |t|
    t.geometry  "geometry_with_spatial_type_and_srid",               spatial_type: 'LINESTRING', srid: 423
    t.geometry  "geometry_with_spatial_type",                        spatial_type: 'LINESTRING'
    t.geometry  "geometry_without_options"
    t.geography "geography_with_spatial_type_and_srid",              spatial_type: 'LINESTRING', srid: 4326
    t.string    "some_array",                           array: true
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end

  create_table "spatial_ref_sys", id: false, force: true do |t|
    t.integer "srid",                   null: false
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

end
