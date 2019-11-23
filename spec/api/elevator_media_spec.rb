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
        expect(content).to include("<div>")
        expect(content).to include("</div>")
    end

  end