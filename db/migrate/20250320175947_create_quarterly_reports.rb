# frozen_string_literal: true

class CreateQuarterlyReports < ActiveRecord::Migration[7.2]
  def change
    create_table :quarterly_reports, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.decimal :opening_value, precision: 20, scale: 2
      t.decimal :closing_value, precision: 20, scale: 2
      t.decimal :profit_rate, precision: 5, scale: 4
      t.decimal :annual_profit_estimate, precision: 10, scale: 4
      t.decimal :semester_profit_estimate, precision: 5, scale: 4
      t.decimal :monthly_profit_rate, precision: 5, scale: 4
      t.decimal :daily_profit_rate, precision: 5, scale: 4
      t.string  :report_target
      t.references :users, type: :binary, null: true, index: true
      t.belongs_to :saving_funds
      t.timestamps
    end
  end
end
