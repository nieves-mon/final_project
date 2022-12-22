class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end

  def new
    @organization = current_user.organization
    @meeting = @organization.meetings.build
  end

  def create
    @organization = current_user.organization
    @meeting = @organization.meetings.build(meeting_params)
    @meeting.user_id = current_user.id
    if @meeting.save
      redirect_to meetings_path, notice: "Meeting was successfully set."
    else
    end
  end

  def show
  end

private
  def meeting_params
    params.require(:meeting).permit(:title, :body, :scheduled_date)
  end

end
