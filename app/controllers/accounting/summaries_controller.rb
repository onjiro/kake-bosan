class Accounting::SummariesController < ApplicationController
  # GET /accounting/items/summaries
  # GET /accounting/items/summaries.json
  def index
    @summaries = Accounting::Entry.summaries @current_user.id, DateTime.parse(params[:from]), DateTime.parse(params[:to])

    respond_to do |format|
      format.json { render json: @summaries, include: { item: { include: :type } } }
    end
  end
end
