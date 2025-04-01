# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SavingsFunds::Indexer do
  context "savings funds succesful indexing" do
    let!(:funds) { create_list(:savings_fund, 2) }
    it "lists savings funds" do
      success_class = described_class.execute!({})

      expect(success_class.failed?).to eq(false)
      expect(success_class.respond_to?(:savings_funds)).to eq(true)
      expect(success_class.savings_funds).to eq(funds)
    end
  end
end
