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

ActiveRecord::Schema[7.0].define(version: 2023_05_17_002522) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bids", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.integer "user_id", null: false
    t.integer "lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_bids_on_lot_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "blocked_cpfs", force: :cascade do |t|
    t.string "cpf"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blocked_by_id", null: false
    t.index ["blocked_by_id"], name: "index_blocked_cpfs_on_blocked_by_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_favorites_on_lot_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "category"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lot_id"
    t.index ["lot_id"], name: "index_items_on_lot_id"
  end

  create_table "lots", force: :cascade do |t|
    t.string "code"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "minimum_bid"
    t.decimal "minimum_bid_increment"
    t.integer "status", default: 1
    t.integer "creator_id"
    t.integer "approver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.integer "user_id", null: false
    t.text "content", null: false
    t.text "answer"
    t.integer "answered_by_id"
    t.boolean "hidden", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answered_by_id"], name: "index_questions_on_answered_by_id"
    t.index ["lot_id"], name: "index_questions_on_lot_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nickname"
    t.string "cpf"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bids", "lots"
  add_foreign_key "bids", "users"
  add_foreign_key "blocked_cpfs", "users", column: "blocked_by_id"
  add_foreign_key "favorites", "lots"
  add_foreign_key "favorites", "users"
  add_foreign_key "items", "lots"
  add_foreign_key "questions", "lots"
  add_foreign_key "questions", "users"
  add_foreign_key "questions", "users", column: "answered_by_id"
end
