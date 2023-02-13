module ProjectParticipantsHelper
    def project_participant_options(project)
        options = User.available_for_project(project).reduce({}) { |hash, user| hash[user.email] = user.email; hash; }
        options.sort.to_h
    end
end
