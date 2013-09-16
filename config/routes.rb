DeviseExample::Application.routes.draw do
  ActiveAdmin.routes(self)
  root 'pages#root'
  devise_for :users
end
