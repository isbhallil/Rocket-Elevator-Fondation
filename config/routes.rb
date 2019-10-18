Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # PagesController
  root 'pages#root'
  get 'residential' => 'pages#resideantial'
  get 'corporate' => 'pages#corporate'

  # QuotesController
  get 'quote' => 'quotes#new'
  post 'quote' => 'quotes#create'
  get 'print'=> 'quotes#print'
  resources :lead
  post '/lead' => 'root#index'
end
