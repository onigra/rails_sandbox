class ErrorsController < ApplicationController
  rescue_from ActionController::RoutingError, with: :render_404

  def show
    raise env['action_dispatch.exception']
  end

  def render_404
    render json: { message: '404' }, status: 404
  end
end
