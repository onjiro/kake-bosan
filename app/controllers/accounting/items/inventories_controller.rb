class Accounting::Items::InventoriesController < ApplicationController
  # GET /accounting/items/inventories
  # GET /accounting/items/inventories.json
  def index
    @inventories = Accounting::Item.inventories @current_user.id, Date.parse(params[:date])

    respond_to do |format|
      format.json { render json: @inventories, include: :item }
    end
  end

  # POST /accounting/items/inventories/1
  # POST /accounting/items/inventories/1.json
  def create
    # todo
  end
end
