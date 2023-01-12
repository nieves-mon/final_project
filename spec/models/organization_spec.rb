require 'rails_helper'

RSpec.describe Organization, type: :model do

    context "when params are valid" do
        it "is valid with valid attributes for organization name" do
            expect(build(:organization)).to be_valid
        end
    end

    context "when params are invalid" do
        it "is not valid if organization name is less than 2 characters" do
            expect(build(:organization, name: 'a')).not_to be_valid
        end
        it "is not valid if organization name is greater than 20 characters" do
            expect(build(:organization, name: 'abcdefghijklmnopqrstuvwxz')).not_to be_valid
        end
    end

    context "when params are incomplete" do
        it "is not valid without a name" do
            expect(build(:organization, name: nil)).not_to be_valid
        end
    end
    
end