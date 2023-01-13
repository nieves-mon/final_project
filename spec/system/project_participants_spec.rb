require 'rails_helper'

RSpec.describe "Project_Participants", type: :system do
    before do
        driven_by(:rack_test)
    end

    def admin_login(admin_account)
        login_as(admin_account, scope: :user)
    end

    def user_login(user_manager)
        login_as(user_manager, scope: :user)
    end

    context "project manager account" do
        organization = FactoryBot.create(:organization)
        employee = FactoryBot.create(:user, organization: organization)
        participating_employee = FactoryBot.create(:user, organization: organization)
        user_manager = FactoryBot.create(:user, :project_manager, organization: organization)
        project = FactoryBot.create(:project, organization: organization)
        manager_project = FactoryBot.create(:project_participant, user: user_manager, project: project)
        participant_project = FactoryBot.create(:project_participant, user: participating_employee, project: project)

        it 'lets you add a project participant' do
            expect(user_manager.roles).to include("project_manager"=>true)
            user_login(user_manager)

            visit new_project_project_participant_path(organization, project)
            expect(page).to have_content('New Project Participant')

            fill_in 'user[email]', with: employee.email
            click_on 'Submit'

            expect(page).to have_content('User successfully added as participant')
        end

        it 'lets you remove participant' do
            expect(user_manager.roles).to include("project_manager"=>true)
            user_login(user_manager)

            visit project_path(organization, project)
            expect(page).to have_content(project.title)
            expect(page).to have_content(participating_employee.email)

            click_on "Delete #{participating_employee.email}"

            expect(page).to have_content('Project participant was successfully removed.')
        end

    end

end
