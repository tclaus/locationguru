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

ActiveRecord::Schema.define(version: 20180312183127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catering_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kind_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "listing_name"
    t.text "summary"
    t.boolean "active"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.decimal "max_persons", precision: 5
    t.boolean "has_heating"
    t.boolean "has_kitchen"
    t.boolean "has_outdoor"
    t.boolean "has_parking_space"
    t.boolean "has_furniture"
    t.string "catering"
    t.boolean "has_air_conditioning"
    t.boolean "has_music_eq"
    t.string "location_type"
    t.string "kind_type"
    t.string "catering_types"
    t.integer "price_level"
    t.float "latitude"
    t.float "longitude"
    t.string "phonenumber"
    t.string "website"
    t.boolean "isExclusiveAvailable"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "location_id"
    t.index ["location_id"], name: "index_photos_on_location_id"
    t.index ["room_id"], name: "index_photos_on_room_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "price"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_reservations_on_location_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.integer "star", default: 1
    t.bigint "location_id"
    t.bigint "reservation_id"
    t.bigint "guest_id"
    t.bigint "host_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reviews_on_guest_id"
    t.index ["host_id"], name: "index_reviews_on_host_id"
    t.index ["location_id"], name: "index_reviews_on_location_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "translations", force: :cascade do |t|
    t.integer "text_id"
    t.string "language_id"
    t.string "category"
    t.string "translation"
    t.index ["text_id", "language_id", "category"], name: "index_translations_on_text_id_and_language_id_and_category"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "provider"
    t.string "uid"
    t.string "image"
    t.string "phone_number"
    t.text "description"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reservations", "locations"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "locations"
  add_foreign_key "reviews", "reservations"
  add_foreign_key "reviews", "users", column: "host_id"
end
