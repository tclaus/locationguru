class ErrorsController < ApplicationController

  def show
    render status_code.to_s, :status => status_code
  end

  def render_error(status)
    render status: status, template: "errors/#{status}"
  end

protected

  def status_code
    params[:code] || 500
  end

end
