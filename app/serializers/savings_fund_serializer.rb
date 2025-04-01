# frozen_string_literal: true

class SavingsFundSerializer < ApplicationSerializer
  attributes :id, :initial_value, :current_value, :profit_rate, :created_at, :updated_at
end
