Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#root'
  get 'quote' => 'pages#quote'
  post 'quote' => 'pages#quote'
  get 'residential' => 'pages#resideantial'
  get 'corporate' => 'pages#corporate'
end
