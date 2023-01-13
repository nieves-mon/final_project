require 'rails_helper'

RSpec.describe "User_meetings", type: :system do
    before do
        driven_by(:rack_test)
    end

    def admin_login(admin_account)
        login_as(admin_account, scope: :user)
    end

    def user_login(user)
        login_as(user, scope: :user)
    end

    context "admin account" do
        organization = FactoryBot.create(:organization)
        admin_account = FactoryBot.create(:user, :admin, organization: organization)
        user = FactoryBot.create(:user, organization: organization)
        meeting = FactoryBot.create(:meeting, organization: organization)
        user_meeting = FactoryBot.create(:user_meeting, meeting: meeting, user: admin_account)

        # it 'lets you add a meeting participant' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit new_meeting_participant_path(meeting.organization_id,user_meeting.meeting_id)
        #     expect(page).to have_content('Add Participant')
        #     fill_in 'user[email]', with: user.email
        #     click_on 'Submit'
        #     expect(page).to have_content('User successfully added as participant')
        # end

        # it 'lets you remove participant' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit new_meeting_participant_path(meeting.organization_id,user_meeting.meeting_id)
        #     expect(page).to have_content('Delete Participant')
        #     fill_in 'user[email]', with: admin_account.email
        #     click_on 'Submit'
        #     expect(page).to have_content('Participant was successfully removed.')
        # end

    end

end
