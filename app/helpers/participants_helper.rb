module ParticipantsHelper
    def meeting_participant_options(meeting)
        options = User.available_for_meeting(meeting).reduce({}) { |hash, user| hash[user.email] = user.email; hash; }
        options.sort.to_h
    end
end
