# @tag InventoriesController
# API for the global inventory.
class InventoriesController < ApplicationController

  # Returns the list of all inventory items
  #
  # @response_status 200
  # @response_class Array<InventorySerializer>
  def index
    @inventories = Inventory.all

    respond_to do |format|
      format.html { render :index, status: :ok }
      format.json { render json: @inventories, status: :ok }
    end    
  end

end
