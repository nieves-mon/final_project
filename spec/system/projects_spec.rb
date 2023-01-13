require 'rails_helper'

RSpec.describe "Projects", type: :system do
    before do
        driven_by(:rack_test)
    end

    def admin_login(admin_account)
        login_as(admin_account, scope: :user)
    end

    context "admin account" do
        organization = FactoryBot.create(:organization)
        admin_account = FactoryBot.create(:user, :project_manager, organization: organization)
        unsaved_project = FactoryBot.build(:project, organization: organization)
        saved_project = FactoryBot.create(:project, organization: organization)
        project_participant = FactoryBot.create(:project_participant, user: admin_account, project: saved_project)

        it 'lets you create a project' do
            expect(admin_account.roles).to include("project_manager"=>true)
            admin_login(admin_account)
            visit new_project_path(admin_account)
            expect(page).to have_content("New Project")

            fill_in 'project[title]', with: unsaved_project.title
            fill_in 'project[body]', with: unsaved_project.body
            fill_in 'project[start_date]', with: unsaved_project.start_date
            fill_in 'project[end_date]', with: unsaved_project.end_date

            expect { click_on 'Submit' }.to change(Project, :count).by(1)
        end

        it 'lets you show project details' do
            expect(admin_account.roles).to include("project_manager"=>true)
            admin_login(admin_account)
            visit project_path(saved_project.organization_id, saved_project.id)
            expect(page).to have_content(saved_project.title)
        end

        it 'lets you edit project details' do
            expect(admin_account.roles).to include("project_manager"=>true)
            admin_login(admin_account)
            visit edit_project_path(saved_project.organization_id,saved_project.id)
            expect(page).to have_content('Edit Project Details')
            fill_in 'project[title]', with: 'Edited Title'
            fill_in 'project[body]', with: 'Edited Body'
            click_on 'Submit'
            expect(page).to have_content('Project was successfully updated.')
        end

        it 'lets you delete project details' do
            expect(admin_account.roles).to include("project_manager"=>true)
            admin_login(admin_account)

            visit projects_path(organization)
            expect(page).to have_content(saved_project.title)

            expect { click_on "Delete #{saved_project.title}" }.to change(Project, :count).by(-1)
        end
    end

end
