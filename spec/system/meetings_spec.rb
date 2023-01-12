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
            meeting.save_zoom_meeting
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit new_meeting_path(organization)
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
            visit meeting_path(meeting.organization_id,meeting.id)
            expect(page).to have_content(meeting.title)
        end

        # it 'lets you edit meeting details' do
        #     meeting.save_zoom_meeting
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit edit_meeting_path(meeting.organization_id,meeting.id)
        #     expect(page).to have_content('Edit Meeting Details')
        #     fill_in 'meeting[title]', with: 'Edited Title'
        #     fill_in 'meeting[body]', with: 'Edited Body'
        #     fill_in 'meeting[scheduled_date]', with: Date.today
        #     click_on 'Submit'
        #     expect(page).to have_content('Meeting was successfully updated.')
        # end

        # it 'lets you delete meeting details' do
        #     meeting.save_zoom_meeting
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     meeting.delete_zoom_meeting(meeting.id)
        #     visit meeting_path(meeting.organization_id,meeting.id)
        #     expect(page).to have_content(meeting.title)
        #     click_on 'Delete'
        #     expect(page).to have_content('Meeting was successfully deleted.')
        # end

    end

end
