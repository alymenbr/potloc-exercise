class InventoriesController < ApplicationController

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all.order(shoe_store_id: :asc)
  end

end
