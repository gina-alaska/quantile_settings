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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120926222140) do

  create_table "locations", :force => true do |t|
    t.decimal  "lon"
    t.decimal  "lat"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "quantile_periods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "quantile_settings", :force => true do |t|
    t.integer  "historical_start"
    t.integer  "historical_end"
    t.integer  "predicted_start"
    t.integer  "predicted_end"
    t.integer  "period_id"
    t.integer  "algorithm"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "status",           :default => "Queued"
  end

  create_table "reports", :force => true do |t|
    t.integer  "low_temp_threshold"
    t.integer  "high_temp_threshold"
    t.string   "column1"
    t.string   "column2"
    t.string   "status",              :default => "new"
    t.integer  "quantile_setting_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "location_id"
  end

end
