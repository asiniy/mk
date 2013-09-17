DeviseExample::Application.routes.draw do
  resources :posts, except: [ :edit, :update, :destroy ]
  root 'pages#root'

  devise_for :users
  ActiveAdmin.routes(self)
end
