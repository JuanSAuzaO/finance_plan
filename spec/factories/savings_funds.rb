# frozen_string_literal: true

FactoryBot.define do
  factory :savings_fund do
    initial_value { 5000000 }
    current_value { 5000000 }
  end
end
