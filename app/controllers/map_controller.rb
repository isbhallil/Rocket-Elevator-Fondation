class MapController < ApplicationController
    def index
    end

    def markers
        res = JSON.parse(File.read('lib/seed/address.json'))
        render :json => res["addresses"]
    end
end