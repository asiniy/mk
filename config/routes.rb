DeviseExample::Application.routes.draw do
  resources :posts, except: [ :index, :edit, :update, :destroy ]
  root 'posts#index'

  devise_for :users
  ActiveAdmin.routes(self)
end
