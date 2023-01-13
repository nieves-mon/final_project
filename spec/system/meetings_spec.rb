require 'rails_helper'

RSpec.describe "Meetings", type: :system do
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
        user_manager = FactoryBot.create(:user, :manager, organization: organization)
        meeting = FactoryBot.create(:meeting, organization: organization)
        admin_meeting = FactoryBot.create(:user_meeting, user: admin_account, meeting: meeting)
        manager_meeting = FactoryBot.create(:user_meeting, user: user_manager, meeting: meeting)

        it 'lets you create a meeting' do
            meeting.save_zoom_meeting
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit new_meeting_path(admin_meeting)
            expect(page).to have_content("New Meeting")
            fill_in 'meeting[title]', with: 'New Meeting'
            fill_in 'meeting[body]', with: 'Meeting Body'
            fill_in 'meeting[scheduled_date]', with: Date.today
            click_on 'Submit'
            expect(page).to have_content('Meeting was successfully set.')
        end

        it 'lets you show meeting details' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit meeting_path(admin_account,meeting)
            expect(page).to have_content(meeting.title)
        end

        # it 'lets you edit meeting details' do
        #     #meeting.save_zoom_meeting
        #     expect(user.roles).to include("manager"=>true)
        #     user_login(user)
        #     visit edit_meeting_path(meeting.organization_id,user_meeting.meeting_id)
        #     expect(page).to have_content('Edit Meeting Details')
        #     fill_in 'meeting[title]', with: 'Edited Title'
        #     fill_in 'meeting[body]', with: 'Edited Body'
        #     fill_in 'meeting[scheduled_date]', with: Date.today
        #     click_on 'Submit'
        #     expect(page).to have_content('Meeting was successfully updated.')
        # end

        # it 'lets you delete meeting details' do
        #     #meeting.save_zoom_meeting
        #     expect(user_manager.roles).to include("manager"=>true)
        #     user_login(user_manager)
        #     #meeting.delete_zoom_meeting
        #     visit meeting_path(admin_account,meeting)
        #     expect(page).to have_content('Title')
        #     click_on 'Delete Meeting'
        #     expect(page).to have_content('Meeting was successfully deleted.')
        # end

    end

end
