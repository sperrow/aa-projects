Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :todos, only: [:index, :show, :create, :update, :destroy]
  end
  
  root to: 'static_pages#root'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
