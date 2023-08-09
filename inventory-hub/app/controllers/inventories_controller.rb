class InventoriesController < ApplicationController

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all
  end

end
