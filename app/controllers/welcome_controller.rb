# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  skip_before_filter :authorize

  def index
    if current_user.nil?
      respond_to do |format|
        format.html
      end
    else
      redirect_to "/topic/index"
    end
  end
end
