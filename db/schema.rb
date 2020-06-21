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

ActiveRecord::Schema.define(version: 2020_06_11_082928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catering_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counters", force: :cascade do |t|
    t.string "context"
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "context_type"
    t.date "date_of_count"
    t.integer "week"
    t.index ["context"], name: "index_counters_on_context"
    t.index ["context_type"], name: "index_counters_on_context_type"
    t.index ["day"], name: "index_counters_on_day"
    t.index ["month"], name: "index_counters_on_month"
    t.index ["year"], name: "index_counters_on_year"
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
    t.string "email"
    t.string "city"
    t.string "country"
    t.boolean "isForPrivateParties", default: false, null: false
    t.boolean "isForClubbing", default: false, null: false
    t.boolean "isForWeddings", default: false, null: false
    t.boolean "isForPhotoFilm", default: false, null: false
    t.boolean "isForBusiness", default: false, null: false
    t.boolean "isForEscapeRoomGames", default: false, null: false
    t.boolean "isForConferences", default: false, null: false
    t.boolean "isForBachelorParties", default: false, null: false
    t.boolean "isForChristmasParties", default: false, null: false
    t.string "suitableForText"
    t.boolean "isPro"
    t.boolean "isRestricted", default: false, null: false
    t.boolean "MailSentNotActivated1", default: false, null: false
    t.boolean "MailSentNotActivated2", default: false, null: false
    t.boolean "MailSentNotActivated3", default: false, null: false
    t.string "subtitle", limit: 200
    t.index ["city"], name: "index_locations_on_city"
    t.index ["country"], name: "index_locations_on_country"
    t.index ["email"], name: "index_locations_on_email"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.string "email"
    t.string "name"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accept"
    t.boolean "isRead", default: false, null: false
    t.date "inquery_date"
    t.index ["location_id"], name: "index_locations_on_location_id"
    t.index ["user_id"], name: "index_message_on_user_id"
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
    t.boolean "is_main"
    t.index ["location_id"], name: "index_photos_on_location_id"
    t.index ["room_id"], name: "index_photos_on_room_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "from_type"
    t.string "status"
    t.text "message"
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
    t.boolean "phone_verified"
    t.string "pin"
    t.boolean "isPremium", default: false, null: false
    t.string "stripe_id"
    t.string "language_id", default: "de"
    t.string "company_name"
    t.string "first_name"
    t.string "last_name"
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
