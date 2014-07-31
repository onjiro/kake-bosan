class Accounting::ItemsController < ApplicationController
  # GET /accounting/items
  # GET /accounting/items.json
  def index
    @accounting_items = Accounting::Item
      .where(user_id: @current_user.id)
      .includes(:type)
      .joins(:type)

    respond_to do |format|
      format.json { render json: @accounting_items, include: :type }
    end
  end
end
