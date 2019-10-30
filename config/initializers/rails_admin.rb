RailsAdmin.config do |config|

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.is_admin?
  end

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
  end
end