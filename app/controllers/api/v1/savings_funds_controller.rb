# frozen_string_literal: true

module Api
  module V1
    class SavingsFundsController < ApplicationController
      def create
        creator = ::SavingsFunds::Creator.execute!(create_params.to_h)
        return error_response(creator) if creator.failed?
        render status: :created
      end

      private

      def create_params
        params.require(:savings_fund).permit(:initial_value, :current_value)
      end
    end
  end
end
