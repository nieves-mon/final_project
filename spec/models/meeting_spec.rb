require 'rails_helper'

RSpec.describe Meeting, type: :model do

    context "when params are valid" do
        it "is valid with valid attributes for meeting" do
            expect(build(:meeting)).to be_valid
        end
    end

    context "when params are invalid" do
        it "is not valid if meeting is less than 2 characters" do
            expect(build(:meeting, title: 'a')).not_to be_valid
        end
        it "is not valid if meeting is greater than 20 characters" do
            expect(build(:meeting, title: 'abcdefghijklmnopqrstuvwxz')).not_to be_valid
        end
    end

    context "when params are incomplete" do
        it "is not valid without a title" do
            expect(build(:meeting, title: nil)).not_to be_valid
        end
        it "is not valid without a scheduled date" do
            expect(build(:meeting, scheduled_date: nil)).not_to be_valid
        end
    end
    
end