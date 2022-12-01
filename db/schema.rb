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

ActiveRecord::Schema.define(version: 2022_12_01_165101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", primary_key: "author_id", id: :serial, force: :cascade do |t|
    t.text "name_author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_author"], name: "uniq_author", unique: true
  end

  create_table "books", primary_key: "book_id", id: :serial, force: :cascade do |t|
    t.text "title"
    t.integer "author_id", null: false
    t.integer "genre_id"
    t.decimal "price", precision: 8, scale: 2
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buy_archives", primary_key: "buy_archive_id", id: :serial, force: :cascade do |t|
    t.integer "buy_id"
    t.integer "client_id"
    t.integer "book_id"
    t.date "date_payment"
    t.integer "amount"
    t.decimal "price", precision: 8, scale: 2
  end

  create_table "buy_books", primary_key: "buy_book_id", id: :serial, force: :cascade do |t|
    t.integer "buy_id"
    t.integer "book_id"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buy_steps", primary_key: "buy_step_id", id: :serial, force: :cascade do |t|
    t.integer "buy_id"
    t.integer "step_id"
    t.date "date_step_beg"
    t.date "date_step_end"
  end

  create_table "buys", primary_key: "buy_id", id: :serial, force: :cascade do |t|
    t.text "buy_description"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", primary_key: "city_id", id: :serial, force: :cascade do |t|
    t.text "name_city", null: false
    t.integer "days_delivery"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_city"], name: "uniq_city", unique: true
  end

  create_table "clients", primary_key: "client_id", id: :serial, force: :cascade do |t|
    t.text "name_client"
    t.integer "city_id"
    t.string "email", limit: 80, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "uniq_email", unique: true
  end

  create_table "genres", primary_key: "genre_id", id: :serial, force: :cascade do |t|
    t.text "name_genre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_genre"], name: "uniq_genre", unique: true
  end

  create_table "steps", primary_key: "step_id", id: :serial, force: :cascade do |t|
    t.text "name_step"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_step"], name: "uniq_name_step", unique: true
  end

  add_foreign_key "books", "authors", primary_key: "author_id", name: "books_author_id_fkey", on_delete: :cascade
  add_foreign_key "books", "genres", primary_key: "genre_id", name: "books_genre_id_fkey", on_delete: :nullify
  add_foreign_key "buy_books", "books", primary_key: "book_id", name: "buy_books_book_id_fkey"
  add_foreign_key "buy_books", "buys", primary_key: "buy_id", name: "buy_books_buy_id_fkey"
  add_foreign_key "buy_steps", "buys", primary_key: "buy_id", name: "buy_steps_buy_id_fkey"
  add_foreign_key "buy_steps", "steps", primary_key: "step_id", name: "buy_steps_step_id_fkey"
  add_foreign_key "buys", "clients", primary_key: "client_id", name: "buys_client_id_fkey"
  add_foreign_key "clients", "cities", primary_key: "city_id", name: "clients_city_id_fkey"
end
