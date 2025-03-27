# frozen_string_literal: true

class SavingsFunds::CreateContract < ApplicationContract
  json do
    required(:initial_value)
    required(:current_value)
  end

  rule(:initial_value) do
    key.failure(I18n.t("contract_errors.errors.int?")) unless is_a_number?(value)
  end

  rule(:current_value) do
    key.failure(I18n.t("contract_errors.errors.int?")) unless is_a_number?(value)
  end

  private

  def is_a_number?(value)
    value.match?(/^\d+(\.\d+)?$/)
  end
end
