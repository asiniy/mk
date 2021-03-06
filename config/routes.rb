DeviseExample::Application.routes.draw do
  resources :comments, only: [ :create, :destroy ]
  resource :profile, only: [ :show, :update ]
  resources :posts, except: [ :index, :edit, :update, :destroy ]
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  ActiveAdmin.routes(self)
  mount RedactorRails::Engine => '/redactor_rails'
end
