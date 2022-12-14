class ParticipantsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_meeting, only: [:new, :create, :delete, :destroy]
  before_action :set_user, only: [:new, :delete ]

  def new
  end

  def create
    @user_in_org = @organization.users.find_by(email: params[:user][:email])
    @user_in_meeting = @meeting.users.find_by(email: params[:user][:email])

    if @user_in_meeting.nil? && @user_in_org.present?
      @participant = @meeting.users << @user_in_org
      redirect_to meetings_path, notice: "User successfully added as participant"
    elsif @user_in_meeting.nil? && @user_in_org.nil?
      redirect_to :new_meeting_participant, notice: "User not a part of the organization"
    else
      redirect_to :new_meeting_participant, notice: "User already a participant in the meeting"
    end
  end

  def delete
  end

  def destroy
    @participant = @meeting.users.find_by(email: params[:user][:email])

    if @participant.present?
      @meeting.users.delete(@participant)
      redirect_to meetings_path, notice: 'Participant was successfully removed.'
    else
      redirect_to :meeting_delete, notice: 'User not a meeting participant'
    end
  end

private

  def set_meeting
    @organization = current_user.organization
    @meeting = @organization.meetings.find(params[:meeting_id])
  end

  def set_user
    @user = @meeting.users.build(email: params[:email])
  end

end
