# frozen_string_literal: true

module SavingsFunds
  class Creator < Base
    extend Errors::Formatter

    def self.execute!(params)
      service = new(params)
      contract = SavingsFunds::CreateContract.new.call(service.params || {})
      return service.fail!(from_contract_errors(contract), status: get_error_code(contract)) if contract.errors.any?
      create_savings_fund!(service)
    end

    private

    def self.create_savings_fund!(service)
      query_result = ::SavingsFund.create!(service.params)
      service.create_method!(query_result)
    end
  end
end
