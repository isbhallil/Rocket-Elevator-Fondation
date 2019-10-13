class PagesController < ApplicationController

    def root
    end

    def quote
        puts "quote : "
        puts params
    end
end
