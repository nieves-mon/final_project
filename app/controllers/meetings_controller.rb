class MeetingsController < ApplicationController
  include SetOrganization
  include RequireOrganization #if no organization is set, access will not be allowed to whole UsersController

  # before_action :set_organization, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :require_manager, only: [:edit, :update, :destroy]
  before_action :require_member, only: [:show]

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
      current_user.update!(manager: true) #anyone who creates a meeting will become its manager
      @meeting.save_zoom_meeting
      @meeting.users << current_user
      redirect_to meetings_path, notice: "Meeting was successfully set."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      @meeting.update_zoom_meeting
      redirect_to meetings_path, notice: "Meeting was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @meeting.delete_zoom_meeting
    @meeting.destroy
    current_user.update!(manager: false)
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

  def require_manager
    if current_user.manager? && @meeting.users.include?(current_user)
        # allow to proceed
    else
        redirect_to meetings_path, alert: "You are not authorized to perform this action."
    end
  end

  def require_member
    if @meeting.users.include?(current_user)
        #allow to proceed
    else
        redirect_to meetings_path, alert: "You are not authorized to perform this action."
    end
  end

end
