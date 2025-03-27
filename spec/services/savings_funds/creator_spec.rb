# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SavingsFunds::Creator do
  context "saving funds succesful creation" do
    let!(:savings_fund_attributes) { { initial_value: "5000000", current_value: "5000000" } }
    it "creates a new savings fund" do
      success_class = described_class.execute!(savings_fund_attributes)

      expect(success_class.failed?).to eq(false)
      expect(success_class.respond_to?(:savings_fund)).to eq(true)
      expect(success_class.savings_fund.initial_value.to_f).to eq(savings_fund_attributes[:initial_value].to_f)
      expect(success_class.savings_fund.current_value.to_f).to eq(savings_fund_attributes[:current_value].to_f)
    end
  end

  context "saving funds creation error" do
    it "fails to create when a param is missing" do
      failed_class = described_class.execute!({ initial_value: "1" })

      expect(failed_class.failed?).to eq(true)
      expect(failed_class.errors[0][:detail]).to eq("current_value " + I18n.t("contract_errors.errors.key?"))
      expect(failed_class.status).to eq(400)
    end

    it "fails to create when params are from an invalid type" do
      failed_class = described_class.execute!({ initial_value: "x", current_value: "x" })
      message = I18n.t("contract_errors.errors.int?")

      expect(failed_class.failed?).to eq(true)
      expect(failed_class.errors[0][:detail]).to eq("initial_value " + message)
      expect(failed_class.errors[1][:detail]).to eq("current_value " + message)
      expect(failed_class.status).to eq(422)
    end
  end
end
