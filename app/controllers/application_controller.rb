class ApplicationController < ActionController::Base
    before_action :init_global_variables
   
    private 
    def init_global_variables
        @navs = Nav.all
        @awards = Award.all
        @news = New.all
        @clients = Client.all
        return @navs, @awards, @news, @clients
    end
end
