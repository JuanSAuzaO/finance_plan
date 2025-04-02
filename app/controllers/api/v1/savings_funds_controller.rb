# frozen_string_literal: true

module Api
  module V1
    class SavingsFundsController < ApplicationController
      def create
        creator = SavingsFunds::Creator.execute!(create_params.to_h)
        return error_response(creator) if creator.failed?
        render json: jsonapi(
          creator.savings_fund,
          SavingsFundSerializer,
          :savings_fund,
          fields: {
            savings_fund: "initial_value, current_value, profit_rate"
          }
        ), status: 201
      end

      def index
        indexer = SavingsFunds::Indexer.execute!(index_params.slice(:filter).to_h)
        paginator, savings_funds = pagy_custom(indexer.savings_funds)
        render json: jsonapi(
          savings_funds,
          SavingsFundSerializer,
          :savings_fund,
          fields: index_params[:fields],
          include: index_params[:include],
          meta: {
            record_count: paginator.count,
            page_count: paginator.last
          }
        )
      end

      private

      def create_params
        params.require(:savings_fund).permit(:initial_value, :current_value)
      end

      def index_params
        params.permit(:include, fields: {}, filter: {}, page: %i[size number])
      end
    end
  end
end
