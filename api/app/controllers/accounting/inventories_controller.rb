class Accounting::InventoriesController < ApplicationController
  # GET /accounting/items/inventories
  # GET /accounting/items/inventories.json
  def index
    @inventories = Accounting::Entry.inventories @current_user.id, DateTime.parse(params[:date])

    respond_to do |format|
      format.json { render json: @inventories }
    end
  end

  # POST /accounting/items/inventories/1
  # POST /accounting/items/inventories/1.json
  def update
    @inventory = Accounting::Entry.take_inventory params[:item_id], @current_user.id, DateTime.parse(params[:date]), params[:amount]

    respond_to do |format|
      format.json { render json: @inventory }
    end
  end
end
