# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SavingsFunds', type: :request do
  describe "#create" do
    let!(:post_route) { "/api/v1/savings_funds" }

    context "with valid params" do
      let!(:savings_fund_attributes) { { initial_value: "5000000", current_value: "5000000" } }
      let!(:succesful_creator) { SavingsFunds::Creator.new(savings_fund_attributes) }
      let!(:savings_fund) { create(:savings_fund, savings_fund_attributes) }
      before do
        allow(SavingsFunds::Creator).to receive(:execute!).and_return(
          succesful_creator.create_method!(savings_fund)
        )
      end
      it "creates a new savings fund correctly" do
        post post_route, params: { savings_fund: savings_fund_attributes }
        attributes = json_response[:data][:attributes]

        expect(response).to have_http_status(:created)
        expect(SavingsFunds::Creator).to have_received(:execute!).with(savings_fund_attributes.with_indifferent_access)
        expect(attributes[:initial_value]).to eq("5000000.0")
        expect(attributes[:current_value]).to eq("5000000.0")
        expect(attributes[:profit_rate]).to eq("0.0")
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
      it "displays a missing key error" do
        post post_route, params: { savings_fund: savings_fund_attributes }

        expect(response).to have_http_status(:bad_request)
        expect(SavingsFunds::Creator).to have_received(:execute!).with(savings_fund_attributes.with_indifferent_access)
        expect(json_response[:errors][0][:detail]).to eq(error_message)
      end
    end
  end

  describe "#index" do
    let!(:get_route) { "/api/v1/savings_funds" }
    let!(:keys) { "initial_value, current_value, profit_rate" }
    context "with valid params" do
      let!(:funds) { create_list(:savings_fund, 2) }
      let!(:params) { { fields: { savings_fund: keys } } }
      let!(:succesful_indexer) { SavingsFunds::Indexer.new(params.slice(:filter)) }
      before do
        allow(SavingsFunds::Indexer).to receive(:execute!).and_return(
          succesful_indexer.create_method!(funds)
        )
      end
      it "lists savings funds correctly" do
        get get_route, params: params
        formatted_funds = funds.map { |record| record.slice(keys.split(", ")).transform_values(&:to_s) }


        expect(response).to have_http_status(:success)
        expect(SavingsFunds::Indexer).to have_received(:execute!).with(params.slice(:filter))
        expect(json_response[:data][0][:attributes]).to eq(formatted_funds[0])
        expect(json_response[:data][1][:attributes]).to eq(formatted_funds[1])
      end
    end

    context "paginator integration" do
      let!(:funds) { create_list(:savings_fund, 6) }
      let!(:params) { { fields: { savings_fund: keys }, page: { size: 2, number: 2 } } }
      let!(:succesful_indexer) { SavingsFunds::Indexer.new(params.slice(:filter)) }
      before do
        allow(SavingsFunds::Indexer).to receive(:execute!).and_return(
          succesful_indexer.create_method!(SavingsFund.all)
        )
      end

      it "lists the third and fourth record only" do
        get get_route, params: params

        expect(response).to have_http_status(:success)
        expect(json_response[:data].count).to eq(2)
        expect(json_response[:data][0][:id]).to eq(funds.third.id)
        expect(json_response[:data][1][:id]).to eq(funds.fourth.id)
      end
    end
  end
end
