# frozen_string_literal: true

class CreateSavingsFunds < ActiveRecord::Migration[7.2]
  def change
    create_table :savings_funds, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.decimal :profit_rate, precision: 10, scale: 4, default: 0
      t.decimal :initial_value, precision: 20, scale: 2
      t.decimal :current_value, precision: 20, scale: 2
      t.timestamps
    end
  end
end
