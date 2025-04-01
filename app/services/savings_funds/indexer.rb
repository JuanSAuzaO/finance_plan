# frozen_string_literal: true

module SavingsFunds
  class Indexer < Base
    def self.execute!(params)
      service = new(params)
      index_savings_funds!(service)
    end

    private

    def self.index_savings_funds!(service)
      query_result = SavingsFund.all
      service.create_method!(query_result)
    end
  end
end
