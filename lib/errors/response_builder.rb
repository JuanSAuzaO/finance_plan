# frozen_string_literal: true

module Errors
  class ResponseBuilder
    extend Formatter

    BASE_RESPONSE = {
      errors: nil
    }.freeze

    def self.build(errors)
      case errors
      when Array
        BASE_RESPONSE.merge(errors: errors)
      when Hash
        BASE_RESPONSE.merge(errors: [ errors ])
      else
        BASE_RESPONSE.merge(errors: [ to_error(errors) ])
      end
    end
  end
end
