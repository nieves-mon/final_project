require 'rails_helper'

RSpec.describe User, type: :model do

    context "when params are valid" do
        it "is valid with admin attributes" do
            expect(build(:user,:admin)).to be_valid
        end
        it "is valid with employee attributes" do
            expect(build(:user)).to be_valid
        end
    end

    context "when params are incomplete" do

        it "is not valid without an email" do
            expect(build(:user, email: nil)).not_to be_valid
        end
        it "is not valid without a password" do
            expect(build(:user, password: nil)).not_to be_valid
        end
        it "is not valid if it does not belong to an organization" do
            expect(build(:user, organization_id: nil)).not_to be_valid
        end

    end
    
end
