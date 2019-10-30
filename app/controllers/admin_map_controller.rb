class AdminMapController < ApplicationController

    def index
        # Localisation du Building
        # Nombre d’étage du building (Si l'information est disponible)
        # Nom du client
        # Nombre de batteries d’ascenseur
        # Nombre de Colonnes
        # Nombre d’ascenseurs
        # Nom complet du contact technique

        @markers = Building.all.map do |building|
            lattitude = building.address.lattitude
            longitude = building.address.longitude
            customer = building.customer.company_name
            batteries = building.batteries.count
            elevators = Elevator.where(:column_id => Column.where(:battery_id => Battery.where(:building_id => building.id))).count
            tech_contact = building.full_name_tech_person
        end
    end
end