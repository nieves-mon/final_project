module ProjectsHelper
    def project_lead(user_id)
        user = User.find(user_id)
        user.email
    end
end
