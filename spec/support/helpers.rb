# frozen_string_literal: true

module Helpers
  def json_response
    JSON.parse(response.body).with_indifferent_access
  end
end

RSpec.configure do |config|
  config.include Helpers
end
