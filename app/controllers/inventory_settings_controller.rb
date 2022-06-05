class InventorySettingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @setting = InventorySetting::find_or_create_by(user_id: @current_user.id) { |setting|
      setting.debit_item_id = 0
      setting.credit_item_id = 0
    }

    respond_to do |format|
      format.json { render json: @setting }
    end
  end

  def update
    @setting = InventorySetting::find(@current_user.id)

    respond_to do |format|
      if @setting.update(update_params)
        format.json { render json: @setting, status: :ok }
      else
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def update_params
    params.require(:inventory_setting).permit(:debit_item_id, :credit_item_id)
  end
end
