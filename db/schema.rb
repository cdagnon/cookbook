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

ActiveRecord::Schema.define(:version => 20110927132641) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.text     "background"
    t.string   "language"
    t.string   "location_state"
    t.string   "location_country"
    t.datetime "registered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_account_id"
  end

  create_table "logins", :force => true do |t|
    t.string   "username"
    t.string   "encrypted_pwd"
    t.string   "salt"
    t.datetime "last_logged_in_at"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.string   "quantity_type"
    t.string   "quantity_count"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "directions"
    t.integer  "entered_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

end
