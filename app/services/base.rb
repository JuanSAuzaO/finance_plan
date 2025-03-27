# frozen_string_literal: true

class Base
  attr_reader :params, :errors, :status

  def initialize(params)
    @params = params
    @failed = false
    @errors = nil
    @status = nil
  end

  def fail!(messages, status: nil)
    @failed = true
    @errors = messages
    @status = status
    self
  end

  def failed?
    @failed
  end

  def create_method!(query_result)
    method_name =
      query_result.respond_to?(:each) ? query_result.last.class.model_name.plural : query_result.model_name.singular
    self.class.define_method(method_name) do
      query_result
    end
    self
  end
end
