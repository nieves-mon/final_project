require 'rails_helper'

RSpec.describe Task, type: :model do

    context "when params are valid" do
        it "is valid with valid attributes for a task" do
            expect(build(:task)).to be_valid
        end
    end

    context "when params are invalid" do
        it "is not valid if task title is less than 2 characters" do
            expect(build(:task, title: 'a')).not_to be_valid
        end
        it "is not valid if task title is greater than 25 characters" do
            expect(build(:task, title: 'abcdefghijklmnopqrstuvwxz12345')).not_to be_valid
        end
        it "is not valid if due date has no date" do
            expect(build(:task, duedate: '')).not_to be_valid
        end
    end

    context "when params are incomplete" do
        it "is not valid without a title" do
            expect(build(:task, title: nil)).not_to be_valid
        end
        it "is not valid without a due date" do
            expect(build(:task, duedate: nil)).not_to be_valid
        end
        it "is not valid if it does not belong to a project" do
            expect(build(:task, project_id: nil)).not_to be_valid
        end
    end
    
end