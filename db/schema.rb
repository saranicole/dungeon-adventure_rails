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

ActiveRecord::Schema.define(:version => 20130101181004) do

  create_table "dungeons", :force => true do |t|
    t.string   "name"
    t.integer  "numEnemies"
    t.text     "iorooms",    :limit => 255
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "player_id",  :limit => 255
    t.integer  "dungeon_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "roomindex"
    t.boolean  "over"
  end

  add_index "games", ["dungeon_id"], :name => "index_games_on_dungeon_id"
  add_index "games", ["player_id"], :name => "index_games_on_player_id"

  create_table "moves", :force => true do |t|
    t.text     "outcome"
    t.integer  "room_id"
    t.string   "direction"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "game_id"
  end

  add_index "moves", ["game_id"], :name => "index_moves_on_game_id"
  add_index "moves", ["room_id"], :name => "index_moves_on_room_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "race"
    t.integer  "stats"
    t.integer  "health"
    t.integer  "game_id"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "items"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "entrance"
    t.string   "exit"
    t.integer  "dungeon_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "contents"
  end

  add_index "rooms", ["dungeon_id"], :name => "index_rooms_on_dungeon_id"

end
