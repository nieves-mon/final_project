class ParticipantsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_meeting, only: [:new, :create, :delete, :destroy]
  before_action :set_user, only: [:new, :delete]
  before_action :require_manager, only: [:new, :create, :delete, :destroy]

  def new
  end

  def create
    @user_in_org = @organization.users.find_by(email: params[:user][:email])
    @user_in_meeting = @meeting.users.find_by(email: params[:user][:email])

    if @user_in_org.meeting_manager?
      redirect_to meetings_path, notice: "User is a meeting manager of another meeting. Hence, cannot be added as a participant to this meeting."
    elsif @user_in_meeting.nil? && @user_in_org.present?
      @participant = @meeting.users << @user_in_org
      redirect_to meetings_path, notice: "User successfully added as participant"
    end
  end

  def destroy
    @participant = @meeting.users.find_by(id: params[:id])

    @meeting.users.delete(@participant)
    redirect_to @meeting, notice: 'Participant was successfully removed.'
  end

private

  def set_meeting
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])
  end

  def set_user
    @user = @meeting.users.build(email: params[:email])
  end

  def require_manager
    if current_user.meeting_manager? && @meeting.users.include?(current_user)
        # allow to proceed
    else
        redirect_to meetings_path, alert: "You are not authorized to perform this action."
    end
  end

end
