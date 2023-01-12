require 'rails_helper'

RSpec.describe "Organizations", type: :system do
    before do
        driven_by(:rack_test)
    end

    def admin_login(admin_account)
        login_as(admin_account, scope: :user)
    end

    context "admin account" do
        organization = FactoryBot.create(:organization)
        admin_account = FactoryBot.create(:user, :admin, organization: organization)
        user = FactoryBot.create(:user, organization: organization)

        it 'lets you show organization details' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit organization_path(organization)
            expect(page).to have_content(organization.name)
        end

        it 'lets you edit organization details' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit edit_organization_path(organization)
            expect(page).to have_content('Edit Organization Details')
            fill_in 'organization[name]', with: 'Edited'
            click_on 'Update Organization'
            expect(page).to have_content('organization was successfully updated.')
        end

        it 'lets you delete organization' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit organization_path(organization)
            expect { click_on 'Delete' }.to change(Organization, :count).by(-1)
        end

        it 'lets you show members of the organization' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit users_path(organization)
            expect(page).to have_content(organization.users.count)
        end

        # it 'lets you edit member details' do
        #     expect(admin_account.admin).to eq(true)
        #     admin_login(admin_account)
        #     visit edit_user_path(admin_account)
        #     fill_in 'user[email]', with: admin_account
        #     page.check('Admin')
        #     click_on 'Update User'
        #     expect(page).to have_content('user was successfully updated.')
        # end

        it 'lets you remove members in the organization' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit user_path(user)
            expect { click_on 'Delete' }.to change(User, :count).by(-1)
        end

        it 'lets you invite members in the organization' do
            expect(admin_account.roles).to include("admin"=>true)
            admin_login(admin_account)
            visit organization_path(organization)
            expect(page).to have_content('Invite Members')
            fill_in "email", with: user.email
            click_on 'Send Invite'
            redirect_to(users_path(organization))
            expect(page).to have_content(user.email)
        end
    end

end
