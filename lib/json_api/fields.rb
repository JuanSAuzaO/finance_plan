# frozen_string_literal: true

module JsonApi::Fields
  module_function

  def deep_symbolize(root:, criteria:)
    criteria ||= {}
    return { "#{root}": [] } if criteria[root.to_s].blank?

    criteria.map { |key, value| [ key.to_sym, JsonApi::Array.symbolize(value) ] }.to_h
  end
end
