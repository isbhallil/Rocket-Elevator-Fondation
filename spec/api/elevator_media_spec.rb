require 'rails_helper'
require 'elevator_media'

describe "Instantiate the streamer class" do
    before do
      @streamer = ElevatorMedia::Streamer.new
    end

    it "should instantiate a new Streamer" do
      expect(@streamer).to be_a(ElevatorMedia::Streamer)
    end

    it "should execute Streamer.get_content" do
        expect(@streamer).to respond_to(:get_content)
    end

  end