class ApplicationController < ActionController::API
  def index
    render json: { message: 'root' }
  end
end
