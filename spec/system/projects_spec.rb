require 'rails_helper'

RSpec.describe "Projects", type: :system do
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
        project = FactoryBot.create(:project, organization: organization)
        project_participant = FactoryBot.create(:project_participant, user: admin_account, project: project)

        # it 'lets you create a project' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit new_project_path(project_participant)
        #     expect(page).to have_content("New Project")
        #     fill_in 'project[title]', with: project.title
        #     fill_in 'project[body]', with: project.body
        #     expect { click_on 'Submit' }.to change(Project, :count).by(1)
        # end

        # it 'lets you show project details' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit project_path(project.organization_id,project.id)
        #     expect(page).to have_content(project.title)
        # end

        # it 'lets you edit project details' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit edit_project_path(project.organization_id,project.id)
        #     expect(page).to have_content('Edit Project Details')
        #     fill_in 'project[title]', with: 'Edited Title'
        #     fill_in 'project[body]', with: 'Edited Body'
        #     click_on 'Submit'
        #     expect(page).to have_content('Project was successfully updated.')
        # end

        # it 'lets you delete project details' do
        #     expect(admin_account.roles).to include("admin"=>true)
        #     admin_login(admin_account)
        #     visit project_path(project.organization_id, project.id)
        #     expect(page).to have_content(project.title)
        #     click_on 'Delete'
        #     expect { click_on 'Submit' }.to change(Project, :count).by(1)
        # end

    end

end
