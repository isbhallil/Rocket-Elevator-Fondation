RailsAdmin.config do |config|
  ### Popular gems integration
  config.authorize_with do |controller|
    if current_user.nil?
      redirect_to main_app.root_path
    elsif !current_user.is_admin?
      redirect_to main_app.root_path
    end
  end
  
  
  # RailsAdmin.config do |config|
    # config.authorize_with do
    #   redirect_to main_app.root_path unless current_user.is_admin?
    # end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    all
    charts

    config.excluded_models = ["Award", "Client", "Nav", "New"]
    
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  
end
