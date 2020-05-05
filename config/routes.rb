Rails.application.routes.draw do
  root "application#index"
  get '/healthcheck', to: 'healthcheck#index'
end
