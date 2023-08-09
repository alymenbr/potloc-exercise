class ShoeStoresController < ApplicationController
  before_action :set_shoe_store, only: %i[ show ]

  # GET /shoe_stores/1 or /shoe_stores/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe_store
      @shoe_store = ShoeStore.find(params[:id])
    end
    
end
