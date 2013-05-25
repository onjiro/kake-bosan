class WelcomeController < ApplicationController
  def index
    @logins = []

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end
end
