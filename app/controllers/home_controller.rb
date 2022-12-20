class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [ :index ]
  skip_before_action :set_organization
  
  def index
  end
end
