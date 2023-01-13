require 'rails_helper'

RSpec.describe "User_meetings", type: :system do
    before do
        driven_by(:rack_test)
    end

    def admin_login(admin_account)
        login_as(admin_account, scope: :user)
    end

    def user_login(user_manager)
        login_as(user_manager, scope: :user)
    end

    context "admin account" do
        organization = FactoryBot.create(:organization)
        admin_account = FactoryBot.create(:user, :admin, organization: organization)
        employee_account = FactoryBot.create(:user, :employee, organization: organization)
        user_manager = FactoryBot.create(:user, :manager, organization: organization)
        meeting = FactoryBot.create(:meeting, organization: organization)
        admin_meeting = FactoryBot.create(:user_meeting, user: admin_account, meeting: meeting)
        manager_meeting = FactoryBot.create(:user_meeting, user: user_manager, meeting: meeting)

        it 'lets you add a meeting participant' do
            expect(user_manager.roles).to include("manager"=>true)
            user_login(user_manager)
            visit new_meeting_participant_path(manager_meeting,meeting)
            expect(page).to have_content('Add Participant')
            fill_in 'user[email]', with: employee_account.email
            click_on 'Submit'
            expect(page).to have_content('User successfully added as participant')
        end

        it 'lets you remove participant' do
            expect(user_manager.roles).to include("manager"=>true)
            user_login(user_manager)
            visit meeting_delete_path(manager_meeting,meeting)
            expect(page).to have_content('Delete Participant')
            fill_in 'user[email]', with: admin_account.email
            click_on 'Submit'
            expect(page).to have_content('Participant was successfully removed.')
        end

    end

end
