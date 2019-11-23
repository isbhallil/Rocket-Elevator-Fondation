module ElevatorMedia

    class Streamer

        def get_content
            swapi_id = rand(1..30)
            person = Swapi.get_person swapi_id
            '<div> <%= person.name > is a hero </div>'
        end
    end


end