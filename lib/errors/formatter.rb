# frozen_string_literal: true

module Errors
  module Formatter
    BAD_REQUEST_ERRORS = %i[key? attr? hash? array? nil?]
    def to_error(detail, path = nil)
      { detail: detail, path: path || Errors::UNKNOWN_ERROR  }
    end

    def get_error_code(contract)
      BAD_REQUEST_ERRORS.include?(contract.errors.messages.first.predicate) ? 400 : 422
    end

    def from_contract_errors(contract)
      return if contract.nil? || contract.errors.blank?

      contract.errors(full: true).messages.map { to_error(_1.text, _1.path.join(", ")) }
    end
  end
end
