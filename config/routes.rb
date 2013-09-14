DeviseExample::Application.routes.draw do
  root 'pages#root'
  devise_for :users
end
