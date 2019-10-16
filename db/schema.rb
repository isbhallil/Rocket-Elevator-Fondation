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

ActiveRecord::Schema.define(version: 2019_10_15_194231) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "address_type", null: false
    t.string "status"
    t.string "entity", null: false
    t.string "number_street", null: false
    t.string "apt_number"
    t.string "city", null: false
    t.string "postal_code", null: false
    t.string "country", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "awards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "building_type"
    t.string "building_name"
    t.string "building_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batteries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "building_id", null: false
    t.bigint "employee_id"
    t.string "building_type", null: false
    t.string "status"
    t.date "date_of_installation"
    t.date "date_of_inspection"
    t.integer "operation_certificate"
    t.text "information"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_batteries_on_building_id"
    t.index ["employee_id"], name: "index_batteries_on_employee_id"
  end

  create_table "building_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "building_id", null: false
    t.string "info_key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_building_details_on_building_id"
  end

  create_table "buildings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "customer_id", null: false
    t.string "full_name_admin_person"
    t.string "email_admin_person"
    t.string "phone_number_admin_person"
    t.string "full_name_tech_person"
    t.string "email_tech_person"
    t.string "phone_number_tech_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_buildings_on_address_id"
    t.index ["customer_id"], name: "index_buildings_on_customer_id"
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image_src"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "columns", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "battery_id", null: false
    t.string "building_type", null: false
    t.integer "floor_number"
    t.string "status"
    t.text "information"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battery_id"], name: "index_columns_on_battery_id"
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "address_id"
    t.bigint "user_id"
    t.date "date_of_creation"
    t.string "company_name", null: false
    t.string "full_name_contact_person"
    t.string "phone_number_contact_person"
    t.string "email_contact_person"
    t.text "company_description"
    t.string "full_name_service_person"
    t.string "phone_number_service_person"
    t.string "email_service_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_customers_on_address_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "elevators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "column_id", null: false
    t.integer "serial_number", null: false
    t.string "model_type", null: false
    t.string "building_type", null: false
    t.string "status"
    t.date "date_of_installation"
    t.date "date_of_inspection"
    t.string "inspection_certificate"
    t.text "information"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_elevators_on_column_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "email"
    t.string "encrypted_password"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "navs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "id_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "link_src"
    t.string "image_src"
    t.string "title"
    t.string "p"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "range-type"
    t.string "building-type"
    t.integer "units"
    t.integer "stories"
    t.integer "basements"
    t.integer "parking-spaces"
    t.integer "max-occupants"
    t.integer "hours"
    t.integer "elevator-shafts"
    t.float "elevator-unit-cost"
    t.float "setup-fees"
    t.float "total"
    t.string "contact"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "batteries", "buildings", on_update: :cascade, on_delete: :cascade
  add_foreign_key "batteries", "employees", on_update: :cascade, on_delete: :cascade
  add_foreign_key "building_details", "buildings", on_update: :cascade, on_delete: :cascade
  add_foreign_key "buildings", "addresses", on_update: :cascade, on_delete: :cascade
  add_foreign_key "buildings", "customers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "columns", "batteries", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customers", "addresses", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customers", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "elevators", "columns", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employees", "users"
end
