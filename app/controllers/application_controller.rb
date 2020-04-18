class ApplicationController < ActionController::API
  def index
    render json: { message: 'ok' }
  end
end
