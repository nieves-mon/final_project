require 'rails_helper'

RSpec.describe "Tasks", type: :system do
    before do
        driven_by(:rack_test)
    end

    def user_login(account)
        login_as(account, scope: :user)
    end

    context "employee account" do
        organization = FactoryBot.create(:organization)
        employee = FactoryBot.create(:user, organization: organization)
        project = FactoryBot.create(:project, organization: organization)
        project_participant = FactoryBot.create(:project_participant, user: employee, project: project)
        unsaved_task = FactoryBot.build(:task, project: project)
        saved_task = FactoryBot.create(:task, project: project)

        it 'lets you create a task' do
            user_login(employee)

            visit new_project_task_path(organization, project)
            expect(page).to have_content("New Task")

            fill_in 'task[title]', with: unsaved_task.title
            fill_in 'task[notes]', with: unsaved_task.notes
            fill_in 'task[duedate]', with: unsaved_task.duedate

            expect { click_on 'Submit' }.to change(Task, :count).by(1)
        end

        it 'lets you show task details' do
            user_login(employee)
            visit project_task_path(organization, project, saved_task)
            expect(page).to have_content(saved_task.title)
        end

        it 'lets you edit task details' do
            user_login(employee)

            visit edit_project_task_path(organization, project, saved_task)
            expect(page).to have_content('Edit Task')

            fill_in 'task[title]', with: 'Edited Title'
            fill_in 'task[notes]', with: 'Edited Notes'
            click_on 'Submit'

            expect(page).to have_content('Task was successfully updated')
        end

        it 'lets you delete a task' do
            user_login(employee)

            visit project_task_path(organization, project, saved_task)
            expect(page).to have_content(saved_task.title)

            expect { click_on "Delete" }.to change(Task, :count).by(-1)
        end
    end

end
