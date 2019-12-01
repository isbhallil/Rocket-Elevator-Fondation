Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  #Test
  get 'test' => 'pages#test'

  # PagesController
  root 'pages#root'
  get 'residential' => 'pages#residential'
  get 'corporate' => 'pages#corporate'

  # QuotesController
  get 'quote' => 'quotes#new'
  post 'quote' => 'quotes#create'
  get 'print'=> 'quotes#print'

  # LeadController
  get 'lead' => 'lead#create'
  post 'lead' => 'lead#create'

  #BuildingsController
  get 'buildings/customers/:customer_id' => 'buildings#customer_buildings'

  #BatteriesController
  get 'batteries/building/:building_id' => 'batteries#building_batteries'

  #ColumnsController
  get 'columns/battery/:battery_id' => 'columns#battery_columns'

  #ElevatorController
  get 'elevators/column/:column_id' => 'elevators#column_elevators'

  # AdminMapController
  get 'map' => 'map#index'

  # InterventionsController
  get 'interventions/new' => 'interventions#new'
  post 'interventions/create' => 'interventions#create'

  # ShipingsController
  get 'shippings' => 'pages#shippings'

  # DropboxController
  get 'dropbox/auth' => 'dropbox#auth'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'

  # Watson
  get 'watson_speak/watson'
end