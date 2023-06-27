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

ActiveRecord::Schema[7.0].define(version: 2023_06_27_023034) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_isbn", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_isbn"], name: "index_bookmarks_on_book_isbn"
    t.index ["user_id", "book_isbn"], name: "index_bookmarks_on_user_id_and_book_isbn", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "books", primary_key: "isbn", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "sales_date"
    t.text "large_image_url"
    t.text "item_url"
    t.text "item_caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookmarks", "books", column: "book_isbn", primary_key: "isbn"
  add_foreign_key "bookmarks", "users"
end
