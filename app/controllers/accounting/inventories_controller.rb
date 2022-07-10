class Accounting::InventoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /accounting/items/inventories
  # GET /accounting/items/inventories.json
  def index
    @inventories = Accounting::Entry.inventories @current_user.id, DateTime.parse(params[:date])

    respond_to do |format|
      format.json { render json: @inventories, include: { item: { include: :type } } }
    end
  end

  def create
    @inventory = Accounting::Entry.take_inventory inventory_params[:item_id], @current_user.id,
                                                  DateTime.parse(inventory_params[:date]), inventory_params[:amount]

    respond_to do |format|
      format.json { render json: @inventory }
    end
  end

  private

  def inventory_params()
    params.require(:inventory).permit(:date, :item_id, :amount)
  end
end
