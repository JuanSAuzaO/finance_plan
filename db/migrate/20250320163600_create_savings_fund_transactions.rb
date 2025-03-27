# frozen_string_literal: true

class CreateSavingsFundTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :savings_fund_transactions, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.integer :amount, precision: 20, scale: 2
      t.string :transaction_type
      t.references :user, type: :binary, null: true, index: true
      t.belongs_to :savings_funds
      t.timestamps
    end
  end
end
