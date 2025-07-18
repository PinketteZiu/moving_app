# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_18_142037) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.string "number", null: false
    t.text "description"
    t.string "destination_room"
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_boxes_on_number", unique: true
    t.index ["room_id"], name: "index_boxes_on_room_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "value", precision: 10, scale: 2, default: "0.0"
    t.string "condition", default: "good"
    t.bigint "room_id", null: false
    t.bigint "box_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_id"], name: "index_items_on_box_id"
    t.index ["condition"], name: "index_items_on_condition"
    t.index ["name"], name: "index_items_on_name"
    t.index ["room_id"], name: "index_items_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_rooms_on_name", unique: true
  end

  add_foreign_key "boxes", "rooms"
  add_foreign_key "items", "boxes"
  add_foreign_key "items", "rooms"
end
