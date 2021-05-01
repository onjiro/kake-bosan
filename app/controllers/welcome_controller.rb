class WelcomeController < ApplicationController
  skip_before_action :authorize

  def index
    redirect_to "/dashboard" if current_user.present?
  end
end
