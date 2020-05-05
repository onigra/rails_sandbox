class HealthcheckController < ApplicationController
  def index
    render json: { message: 'ok' }
  end
end
