class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]

  # GET /tenants
  def index
    @tenants = Tenant.all
  end

  # GET /tenants/1
  def show
    @tenant_members = @tenant.users
  end

  def invite_a_member_of
    current_tenant = current_user.tenant
    email = params[:email]
    user_in_db = User.where(email: email).first
    if user_in_db.present?
      redirect_to users_path, alert: "email #{email} already in use"
    elsif user_in_db.nil?
      User.invite!({ email: email, tenant: current_tenant }, current_user) #devise_invitable
      redirect_to users_path, notice: "#{email} was invited to join the organization #{current_tenant.name}"
    end
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
  end

  # POST /tenants
  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      current_user.update(tenant: @tenant)
      redirect_to @tenant, notice: 'Tenant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tenants/1
  def update
    if @tenant.update(tenant_params)
      redirect_to @tenant, notice: 'Tenant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy
    redirect_to tenants_url, notice: 'Tenant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tenant_params
      params.require(:tenant).permit(:name)
    end
end
