class PagesController < ApplicationController

    def root
        @time = Time.now
    end
end
