module ElevatorMedia

    class Streamer

        def get_content
            person = get_character
            adjective = get_adjective

            '<div> <%= person["name"] %> is a <%= adjective %> </div>'
        end

        def get_character
            swapi_id = rand(1..30)
            person = Swapi.get_person swapi_id
            JSON.parse(person)
        end

        def get_adjective
            adjectives_list = ['hero', 'badass', 'monster', 'princess', 'fish', 'cucumber', 'popcorn']
            adjective = adjectives_list[rand(0...adjectives_list.count)]
        end
    end


end