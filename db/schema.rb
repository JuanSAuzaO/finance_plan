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

ActiveRecord::Schema[7.2].define(version: 2025_03_20_175947) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quarterly_reports", id: :binary, force: :cascade do |t|
    t.decimal "opening_value", precision: 20, scale: 2
    t.decimal "closing_value", precision: 20, scale: 2
    t.decimal "profit_rate", precision: 5, scale: 4
    t.decimal "annual_profit_estimate", precision: 10, scale: 4
    t.decimal "semester_profit_estimate", precision: 5, scale: 4
    t.decimal "monthly_profit_rate", precision: 5, scale: 4
    t.decimal "daily_profit_rate", precision: 5, scale: 4
    t.string "report_target"
    t.binary "users_id"
    t.bigint "saving_funds_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["saving_funds_id"], name: "index_quarterly_reports_on_saving_funds_id"
    t.index ["users_id"], name: "index_quarterly_reports_on_users_id"
  end

  create_table "savings_fund_transactions", id: :binary, force: :cascade do |t|
    t.integer "amount"
    t.string "transaction_type"
    t.binary "user_id"
    t.bigint "savings_funds_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["savings_funds_id"], name: "index_savings_fund_transactions_on_savings_funds_id"
    t.index ["user_id"], name: "index_savings_fund_transactions_on_user_id"
  end

  create_table "savings_funds", id: :binary, force: :cascade do |t|
    t.decimal "profit_rate", precision: 10, scale: 4, default: "0.0"
    t.decimal "initial_value", precision: 20, scale: 2
    t.decimal "current_value", precision: 20, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :binary, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "phone_country_code"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_saving_funds", id: :binary, force: :cascade do |t|
    t.decimal "inital_investment_amount", precision: 20, scale: 2
    t.decimal "current_investment_amount", precision: 20, scale: 2
    t.decimal "fund_share", precision: 5, scale: 4
    t.bigint "users_id"
    t.bigint "saving_funds_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["saving_funds_id"], name: "index_users_saving_funds_on_saving_funds_id"
    t.index ["users_id"], name: "index_users_saving_funds_on_users_id"
  end
end
