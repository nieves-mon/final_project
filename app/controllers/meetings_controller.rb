class MeetingsController < ApplicationController

  include SetOrganization
  include RequireOrganization #if no organization is set, access will not be allowed to whole UsersController

  # before_action :set_organization, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = current_user.meetings
    @datetoday = Date.current
    @overdue = current_user.meetings.where('scheduled_date < ?', @datetoday)
    @today = current_user.meetings.where('scheduled_date = ?', @datetoday)
    @soon = current_user.meetings.where('scheduled_date > ?', @datetoday)
  end

  def show
    @participants = @meeting.users
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      @meeting.users << current_user
      redirect_to meetings_path, notice: "Meeting was successfully set."
    end
  end

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to meetings_path, notice: "Meeting was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    redirect_to meetings_path, notice: "Meeting was successfully deleted."
  end

private
  # def set_organization
  #   @organization = current_user.organization
  # end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :body, :scheduled_date)
  end

end
