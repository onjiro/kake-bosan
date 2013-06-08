class WelcomeController < ApplicationController
  def index
    @logins = []

    respond_to do |format|
      format.html
      format.json { render json: @logins }
    end
  end
end
