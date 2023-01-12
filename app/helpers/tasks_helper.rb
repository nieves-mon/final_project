module TasksHelper
    def task_assignee_options(project)
        options = project.users.reduce({}) { |hash, user| hash[user.email] = user.id; hash; }
        options["Don't Assign Yet"] = 0
        options
    end
end
