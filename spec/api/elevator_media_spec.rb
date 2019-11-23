require 'rails_helper'
require 'elevator_media'

describe "ElevatorMedia::Streamer" do
    before do
      @streamer = ElevatorMedia::Streamer.new
    end

    it "should instantiate a new Streamer" do
      expect(@streamer).to be_a(ElevatorMedia::Streamer)
    end

    it "should execute Streamer.get_content" do
        expect(@streamer).to respond_to(:get_content)
    end

    it "should @streamer.get_content return valid html" do
        content = @streamer.get_content()
        expect(content).to be_a(String)
        expect(content).to include("<div>")
        expect(content).to include("</div>")
    end

    it "should get a starwars character" do
        person = @streamer.get_character
        expect(person).not_to be_empty
    end

    it "should get a starwars character with a name attribute" do
        person = @streamer.get_character
        expect(person).to have_key("name")
    end

    it "should get return an adjective" do
        adjective = @streamer.get_adjective
        expect(adjective).not_to be_empty
    end

    it "should get a adjective from" do
        adjectives_list = ['hero', 'badass', 'monster', 'princess', 'fish', 'cucumber', 'popcorn']
        adjective = @streamer.get_adjective
        expect(adjectives_list).to include(adjective)
    end

  end