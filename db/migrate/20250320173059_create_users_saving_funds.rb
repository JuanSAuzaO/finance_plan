# frozen_string_literal: true

class CreateUsersSavingFunds < ActiveRecord::Migration[7.2]
  def change
    create_table :users_saving_funds, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.decimal :inital_investment_amount, precision: 20, scale: 2
      t.decimal :current_investment_amount, precision: 20, scale: 2
      t.decimal :fund_share, precision: 5, scale: 4
      t.belongs_to :users
      t.belongs_to :saving_funds
      t.timestamps
    end
  end
end
