require 'rails_helper'

RSpec.describe "Meetings", type: :system do
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

        it 'lets you create a meeting' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(user)
            visit new_meeting_path(organization)
            expect(page).to have_content("New Meeting")
            fill_in 'meeting[title]', with: 'New Meeting'
            fill_in 'meeting[body]', with: 'Meeting Body'
            fill_in 'meeting[scheduled_date]', with: Date.today
            click_on 'Submit'
        end

        it 'lets you show meeting details' do
            expect(admin_account.roles).to include("admin"=>true)
            user_login(user)
            visit meeting_path(meeting.organization_id,meeting.id)
            expect(page).to have_content(meeting.title)
        end

        # it 'lets you edit meeting details' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     user_login(user)
        #     visit edit_meeting_path(meeting.organization_id,meeting.id,meeting.zoom_id)
        #     expect(page).to have_content('Edit Meeting Details')
        #     fill_in 'meeting[title]', with: 'Edited Title'
        #     fill_in 'meeting[body]', with: 'Edited Body'
        #     fill_in 'meeting[scheduled_date]', with: Date.today
        #     click_on 'Submit'
        #     expect(page).to have_content('Meeting was successfully updated.')
        # end

        # it 'lets you delete meeting details' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     user_login(user)
        #     visit meeting_path(meeting.organization_id,meeting.id,)
        #     expect(page).to have_content(meeting.title)
        #     click_on 'Delete'
        #     expect(page).to have_content('Meeting was successfully deleted.')
        # end

        it 'lets you add a meeting participant' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit new_meeting_participant_path(meeting.organization_id,meeting.id)
            expect(page).to have_content('Add Participant')
            fill_in 'user[email]', with: user.email
            click_on 'Submit'
            expect(page).to have_content('User successfully added as participant')
        end

        # it 'lets you remove participant' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit meeting_delete_path(meeting.organization_id,meeting.id)
        #     expect(page).to have_content('Delete Participant')
        #     fill_in 'user[email]', with: user.email
        #     click_on 'Submit'
        #     #expect(page).to have_content('Participant was successfully removed.')
        # end

    end

end
