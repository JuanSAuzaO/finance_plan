# frozen_string_literal: true

FactoryBot.define do
  factory :savings_fund do
    initial_value { FFaker::Random.rand(1000000...9000000) }
    current_value { initial_value }
  end
end
