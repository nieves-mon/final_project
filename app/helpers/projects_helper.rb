module ProjectsHelper
    def project_lead(user_id)
        user = User.find(user_id)
        user.email
    end

    def project_status(project)
        if project.complete
            "Complete"
        elsif project.end_date < Date.current
            "Overdue"
        else
            "Pending"
        end
    end
end
