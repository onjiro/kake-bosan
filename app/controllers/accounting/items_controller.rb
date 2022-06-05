class Accounting::ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  def create
    @item = Accounting::Item.new(item_params)

    respond_to do |format|
      if @item.save
        logger.debug(@item)
        format.json { render json: @item.to_json, status: :created, location: @item }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounting/items/1
  # PUT /accounting/items/1.json
  def update
    @accounting_item = Accounting::Item.find_by(id: params[:id], user_id: @current_user.id)
    logger.info @accounting_item.inspect

    respond_to do |format|
      if @accounting_item.update(item_params)
        format.json { head :no_content }
      else
        format.json { render json: @accounting_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def item_params
    params.require(:item)
      .permit(:name, :type_id, :description, :selectable, :type_id)
      .merge(user_id: @current_user.id)
  end
end
