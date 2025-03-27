class ApplicationController < ActionController::API
  def error_response(service)
    render json: Errors::ResponseBuilder.build(service.errors), status: service.status
  end
end
