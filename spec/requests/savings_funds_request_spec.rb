# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SavingsFunds', type: :request do
  describe "#create" do
    let!(:post_route) { "/api/v1/savings_funds" }

    context "with valid params" do
      let!(:savings_fund_attributes) { { initial_value: "5000000", current_value: "5000000" } }
      let!(:succesful_creator) { SavingsFunds::Creator.new(savings_fund_attributes) }
      let!(:savings_fund) { create(:savings_fund) }
      before do
        allow(SavingsFunds::Creator).to receive(:execute!).and_return(
          succesful_creator.create_method!(savings_fund)
        )
      end
      it "creates a new savings fund correctly" do
        post post_route, params: { savings_fund: savings_fund_attributes }

        expect(response).to have_http_status(:created)
        expect(SavingsFunds::Creator).to have_received(:execute!).with(savings_fund_attributes.with_indifferent_access)
      end
    end

    context "with invalid params" do
      let!(:savings_fund_attributes) { { initial_value: "1" } }
      let!(:failed_creator) { SavingsFunds::Creator.new(savings_fund_attributes) }
      let!(:error_message) { "current_value " + I18n.t("contract_errors.errors.key?") }
      before do
        allow(SavingsFunds::Creator).to receive(:execute!).and_return(
          failed_creator.fail!(error_message, status: 400)
        )
      end
      it "creates a new savings fund correctly" do
        post post_route, params: { savings_fund: savings_fund_attributes }

        expect(response).to have_http_status(:bad_request)
        expect(SavingsFunds::Creator).to have_received(:execute!).with(savings_fund_attributes.with_indifferent_access)
        expect(json_response[:errors][0][:detail]).to eq(error_message)
      end
    end
  end
end
