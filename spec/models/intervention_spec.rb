require 'rails_helper'

describe Intervention do
    subject { Intervention.new(
        :author_id => 1,
        :customer_id => 1,
        :building_id => 1,
        :battery_id => 1,
        :column_id => 1,
        :elevator_id => 1,
        :employee_id => 1,
        :report => "blablabla"
    )}

    it "should belongs to customer" do
        association = Intervention.reflect_on_association(:customer)
        expect(association.macro).to eq :belongs_to
    end

    it "should belongs to building" do
        association = Intervention.reflect_on_association(:building)
        expect(association.macro).to eq :belongs_to
    end

    it "should belongs to battery" do
        association = Intervention.reflect_on_association(:battery)
        expect(association.macro).to eq :belongs_to
    end

    it "should belongs to column" do
        association = Intervention.reflect_on_association(:column)
        expect(association.macro).to eq :belongs_to
    end

    it "should belongs to elevator" do
        association = Intervention.reflect_on_association(:elevator)
        expect(association.macro).to eq :belongs_to
    end

end