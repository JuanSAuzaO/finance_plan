# frozen_string_literal: true

module JsonApi::Include
  module_function


  def deep_symbolize(string)
    JsonApi::Array.symbolize(string)
  end
end
