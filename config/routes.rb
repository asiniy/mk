DeviseExample::Application.routes.draw do
  resource :profile, only: [ :show, :update ]
  resources :posts, except: [ :index, :edit, :update, :destroy ]
  root 'posts#index'

  devise_for :users
  ActiveAdmin.routes(self)
  mount RedactorRails::Engine => '/redactor_rails'
end
