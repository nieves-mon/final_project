class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :edit, :update, :destroy]

    # GET /organizations
    def index
        @organizations = Organization.all
    end

    # GET /organizations/1
    def show
        @organization_members = @organization.users
    end

    def invite_a_member_of
        current_organization = current_user.organization
        email = params[:email]
        if email.present?
            user_in_db = User.where(email: email).first

            if user_in_db.present?
                redirect_to users_path, alert: "email #{email} already in use"
            elsif user_in_db.nil?
                User.invite!({ email: email, organization: current_organization }, current_user) #devise_invitable
                redirect_to users_path, notice: "#{email} was invited to join the organization #{current_organization.name}"
            end
        else
            redirect_to root_path, alert: "No email was provided!"
        end
    end

    def members
        @organization = current_user.organization
        @organization_members = @organization.users
    end

    # GET /organizations/new
    # def new
    #     @organization = Organization.new
    # end

    # POST /organizations
    # def create
    #     @organization = Organization.new(organization_params)

    #     if @organization.save
    #         current_user.update(organization: @organization)
    #         redirect_to @organization, notice: 'organization was successfully created.'
    #     else
    #         render :new
    #     end
    # end

    # GET /organizations/1/edit
    def edit
    end

    # PATCH/PUT /organizations/1
    def update
        if @organization.update(organization_params)
            redirect_to @organization, notice: 'organization was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /organizations/1
    def destroy
        @organization.destroy
        redirect_to organizations_url, notice: 'organization was successfully destroyed.'
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_organization
            @organization = Organization.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def organization_params
            params.require(:organization).permit(:name)
        end
end
