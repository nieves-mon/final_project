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
    @meeting.user_id = current_user.id
    if @meeting.save
      redirect_to meetings_path, notice: "Meeting was successfully set."
    else
    end
  end

  def show
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:id])
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

private
  def meeting_params
    params.require(:meeting).permit(:title, :body, :scheduled_date)
  end

end
