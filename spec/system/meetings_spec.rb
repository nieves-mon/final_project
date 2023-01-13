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
        user_manager = FactoryBot.create(:user, :meeting_manager, organization: organization)
        # meeting = FactoryBot.create(:meeting, organization: organization)
        # admin_meeting = FactoryBot.create(:user_meeting, user: admin_account, meeting: meeting)
        # manager_meeting = FactoryBot.create(:user_meeting, user: user_manager, meeting: meeting)
        unsaved_meeting = FactoryBot.build(:meeting, organization: organization)
        saved_meeting = FactoryBot.create(:meeting, organization: organization)
        user_meeting = FactoryBot.create(:user_meeting, user: user_manager, meeting: saved_meeting)

        it 'lets you create a meeting' do
            # meeting.save_zoom_meeting
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)

            visit new_meeting_path(unsaved_meeting.organization)
            expect(page).to have_content("New Meeting")

            fill_in 'meeting[title]', with: unsaved_meeting.title
            fill_in 'meeting[body]', with: unsaved_meeting.body
            fill_in 'meeting[scheduled_date]', with: unsaved_meeting.scheduled_date
            click_on 'Submit'

            expect(page).to have_content('Meeting was successfully set.')
        end

        it 'lets you show meeting details' do
            expect(user_manager.roles).to include("meeting_manager"=>true)

            user_login(user_manager)
            visit meeting_path(saved_meeting.organization , saved_meeting)

            expect(page).to have_content(saved_meeting.title)
        end

        it 'lets you edit meeting details' do
            saved_meeting.save_zoom_meeting
            expect(user_manager.roles).to include("meeting_manager"=>true)
            user_login(user_manager)

            visit edit_meeting_path(saved_meeting.organization_id, saved_meeting.id)
            expect(page).to have_content('Edit Meeting Details')

            fill_in 'meeting[title]', with: 'Edited Title'
            fill_in 'meeting[body]', with: 'Edited Body'
            fill_in 'meeting[scheduled_date]', with: Date.today
            click_on 'Submit'

            expect(page).to have_content('Meeting was successfully updated.')
        end

        it 'lets you delete meeting details' do
            saved_meeting.save_zoom_meeting
            expect(user_manager.roles).to include("meeting_manager"=>true)
            user_login(user_manager)

            visit meeting_path(saved_meeting.organization , saved_meeting)

            expect(page).to have_content(saved_meeting.title)
            p saved_meeting
            # saved_meeting.delete_zoom_meeting
            click_on 'Delete Meeting'

            expect(page).to have_content('Meeting was successfully deleted.')
        end

    end

end
