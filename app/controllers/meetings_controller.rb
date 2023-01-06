class MeetingsController < ApplicationController
  def index
    @organization = current_user.organization
    @meetings = @organization.meetings
  end

  def new
    @organization = current_user.organization
    @meeting = @organization.meetings.build
  end

  def create
    @organization = current_user.organization
    @meeting = @organization.meetings.build(meeting_params)
    @meeting.save_zoom_link(@meeting.title)

    if @meeting.save
      @user_meeting = current_user.user_meetings.create(user_id:current_user.id,meeting_id:@meeting.id)
      redirect_to meetings_path, notice: "Meeting was successfully set."
    end
  end

  def show
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:id])
    @participants = @meeting.users
  end

  def edit
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:id])
  end

  def update
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to meetings_path, notice: "Meeting was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:id])
    @meeting.destroy
    redirect_to meetings_path, notice: "Meeting was successfully deleted."
  end

  def new_user
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])
    @set_user_meeting = @meeting.user_meetings.build(meeting_id:params[:meeting_id])
  end

  def create_user
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])

    @user_in_meeting = @meeting.users.where(email: params[:user_meeting][:email]).first
    @user_in_org = @organization.users.where(email: params[:user_meeting][:email]).first
    if @user_in_meeting.nil? && @user_in_org.present?
      @user_meeting = @user_in_org.user_meetings.create(user_id:@user_in_org.id, meeting_id: params[:meeting_id])
      redirect_to meetings_path, notice: "User successfully added as participant"
    elsif @user_in_meeting.nil? && @user_in_org.nil?
      redirect_to meeting_new_user_path, notice: "User not a part of the organization"
    else
      redirect_to meeting_new_user_path, notice: "User already a participant in the meeting"
    end

  end

private
  def meeting_params
    params.require(:meeting).permit(:title, :body, :scheduled_date)
  end

end
