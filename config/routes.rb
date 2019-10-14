Rails.application.routes.draw do
  devise_for :users

  # PagesController
  root 'pages#root'
  get 'residential' => 'pages#resideantial'
  get 'corporate' => 'pages#corporate'

  # QuotesController
  get 'quote' => 'quotes#new'
  post 'quote' => 'quotes#create'
  get 'contact'=> 'quotes#contact'
end
