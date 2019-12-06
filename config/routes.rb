Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  #Test
  get 'test' => 'pages#test'

  # PagesController
  root 'pages#root'
  get 'residential'         => 'pages#residential'
  get 'corporate'           => 'pages#corporate'
  get 'speech'              => 'pages#speech'
  get 'confirm_profile'     => 'pages#confirm_profile'
  get 'delete_profile'      => 'pages#delete_profile'
  get 'confirm_enroll'      => 'pages#confirm_enroll'
  get 'identified_profile'  => 'pages#identified_profile'

  # QuotesController
  get 'quote'   => 'quotes#new'
  post 'quote'  => 'quotes#create'
  get 'print'   => 'quotes#print'

  # LeadController
  get 'lead'  => 'lead#create'
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
  get 'interventions/new'     => 'interventions#new'
  post 'interventions/create' => 'interventions#create'

  # ShipingsController
  get 'shippings' => 'pages#shippings'

  # DropboxController
  get 'dropbox/auth'          => 'dropbox#auth'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'

  # Watson
  get 'watson_speak/watson'

  # SpeechController
  post '/create_profile'    => 'speech#create_rofile'
  post '/delete_profile'    => 'speech#delete_profile'
  post '/enroll_profile'    => 'speech#enroll_profile'
  post '/transpile_audio'   => 'speech#transpile_profile'
end