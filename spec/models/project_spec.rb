require 'rails_helper'

RSpec.describe Project, type: :model do

    context "when params are valid" do
        it "is valid with valid attributes for project" do
            expect(build(:project)).to be_valid
        end
    end

    context "when params are invalid" do
        it "is not valid if project title is less than 2 characters" do
            expect(build(:project, title: 'a')).not_to be_valid
        end
        it "is not valid if project title is greater than 20 characters" do
            expect(build(:project, title: 'abcdefghijklmnopqrstuvwxz')).not_to be_valid
        end

        it "is not valid if project dates have no dates" do
            expect(build(:project, start_date: '', end_date: '')).not_to be_valid
        end
    end

    context "when params are incomplete" do
        it "is not valid without a title" do
            expect(build(:project, title: nil)).not_to be_valid
        end
        it "is not valid without a start_date" do
            expect(build(:project, start_date: nil)).not_to be_valid
        end
        it "is not valid without an end_date" do
            expect(build(:project, end_date: nil)).not_to be_valid
        end
        it "is not valid if it does not belong to an organization" do
            expect(build(:project, organization_id: nil)).not_to be_valid
        end
    end
    
end