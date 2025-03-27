# frozen_string_literal: true

module UlidPk
  extend ActiveSupport::Concern

  included do
    before_create :set_ulid
  end

  def set_ulid
    self.id = ULID.generate if self.class.column_names.include?("id")
  end
end
