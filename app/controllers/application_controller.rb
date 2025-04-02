class ApplicationController < ActionController::API
  def error_response(service)
    render json: Errors::ResponseBuilder.build(service.errors), status: service.status
  end

  def jsonapi(query, serializer, root, opts = {})
    serializer.new(
      query,
      fields: JsonApi::Fields.deep_symbolize(root: root, criteria: opts[:fields]&.as_json),
      include: JsonApi::Include.deep_symbolize(opts[:include]),
      links: opts[:links] || {},
      meta: opts[:meta] || {},
      params: opts[:params] || {}
    ).serializable_hash
  end

  def pagy_custom(collection)
    Paginators::CustomPagy.paginate(
      collection, limit: params.dig(:page, :size) || 20, page: params.dig(:page, :number) || 1
    )
  end
end
