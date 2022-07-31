class Accounting::ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /accounting/items
  # GET /accounting/items.json
  def index
    items = @current_user.items.eager_load(:type)

    respond_to do |format|
      format.json { render json: items, include: :type }
    end
  end

  def create
    item = Accounting::Item.new(item_create_params)

    respond_to do |format|
      if item.save
        format.json { render json: item.to_json, status: :created, location: item }
      else
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    item = @current_user.items.find(item_update_params[:id])

    respond_to do |format|
      if item.update(item_update_params)
        format.json { head :no_content }
      else
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def item_create_params
    params.require(:item)
      .permit(:name, :type_id, :description, :selectable, :type_id)
      .merge(user_id: @current_user.id)
  end

  def item_update_params
    params.require(:item)
      .permit(:id, :name, :type_id, :description, :selectable, :type_id)
      .merge(user_id: @current_user.id)
  end
end
