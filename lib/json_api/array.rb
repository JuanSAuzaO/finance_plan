# frozen_string_literal: true

module JsonApi::Array
  module_function

  def symbolize(string)
    string ||= ""
    string.delete(" ").split(",").map(&:to_sym)
  end
end
