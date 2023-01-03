class UsersController < ApplicationController
  include SetOrganization
  include RequireOrganization #if no organization is set, access will not be allowed to whole UsersController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:show, :edit, :update, :destroy, :resend_invitation]
  
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
        redirect_to @user, notice: 'user was successfully updated.'
    else
        render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'user was successfully destroyed.'
  end

  def resend_invitation
    @user = User.find(params[:id])
    if @user.invitation_accepted_at.present?
      redirect_to users_path, alert: "User with email #{@user.email} has already accepted the invitation"
    else
      @user.invite!
      redirect_to users_path, notice: "Invitation resent to #{@user.email}"
    end
  end

  private
    
  def set_user
    @user = User.find(params[:id])
  end

  
  def user_params
    params.require(:user).permit(:email, *User::ROLES)
  end

  def require_admin
    if current_user.admin?
      # allow to proceed
    else
      redirect_to users_path, alert: "You are not authorized to perform this action."
    end
  end

end