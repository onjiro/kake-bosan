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

  # PUT /accounting/items/1
  # PUT /accounting/items/1.json
  def update
    @accounting_item = Accounting::Item.find_by(id: params[:id], user_id: @current_user.id)
    logger.info @accounting_item.inspect

    respond_to do |format|
      if @accounting_item.update_attributes update_params
        format.json { head :no_content }
      else
        format.json { render json: @accounting_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def update_params
    {
      name: params[:name],
      type_id: params[:type_id],
      description: params[:description],
      selectable: params[:selectable],
    }
  end
end
