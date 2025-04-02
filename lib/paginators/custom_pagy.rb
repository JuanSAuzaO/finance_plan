# frozen_string_literal: true

module Paginators
  module CustomPagy
    extend Pagy::Backend
    module_function

    def paginate(collection, opts = {})
      pagy = Pagy.new(count: collection.size, **opts)
      return [ pagy, collection[pagy.offset, pagy.in] ] if collection.is_a?(Array)
      pagy(collection, **opts)
    end
  end
end
