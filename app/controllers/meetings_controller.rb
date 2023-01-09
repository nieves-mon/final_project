class MeetingsController < ApplicationController

  before_action :set_organization, only: [:index, :show, :new, :create, :edit, :update, :destroy]
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
    @meeting = @organization.meetings.build
  end

  def create
    @meeting = @organization.meetings.build(meeting_params)
    if @meeting.save
      @user_meeting = current_user.user_meetings.create(user_id:current_user.id,meeting_id:@meeting.id)
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

  def new_user
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])
    @user = @meeting.users.build(email: params[:email])
  end

  def create_user
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])

    @user_in_org = @organization.users.find_by(email: params[:user][:email])
    @user_in_meeting = @meeting.users.find_by(email: params[:user][:email])

    if @user_in_meeting.nil? && @user_in_org.present?
      @participant = @meeting.users << @user_in_org
      redirect_to meetings_path, notice: "User successfully added as participant"
    elsif @user_in_meeting.nil? && @user_in_org.nil?
      redirect_to :meeting_new_user, notice: "User not a part of the organization"
    else
      redirect_to :meeting_new_user, notice: "User already a participant in the meeting"
    end
  end

  def delete_user
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])
    @user = @meeting.users.build(email: params[:email])
  end

  def destroy_user
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])
    @participant = @meeting.users.find_by(email: params[:user][:email])

    if @participant.present?
      @meeting.users.delete(@participant)
      redirect_to meetings_path, notice: 'Participant was successfully removed.'
    else
      redirect_to :meeting_delete_user, notice: 'User not a meeting participant'
    end
  end

private
  def set_organization
    @organization = current_user.organization
  end

  def set_meeting
    @meeting = @organization.meetings.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :body, :scheduled_date)
  end

end
