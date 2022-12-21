module RequireOrganization
  extend ActiveSupport::Concern

  included do
    before_action :require_organization
    #if no tenant is set, results become unscoped (behavior of acts_as_tenant gem)
    #therefore, require_organization method is required for all models that will be using acts_as_tenant(:organization)
    #info: https://github.com/ErwinM/acts_as_tenant#scoping-your-models
    def require_organization
      if ActsAsTenant.current_tenant.nil?
        redirect_to root_path, alert: "No tenant set!"
      end
    end

  end
  
end