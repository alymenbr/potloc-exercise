# @tag ShoeStoresController
# API for inventory of a specific shoe store.
class ShoeStoresController < ApplicationController
  before_action :set_shoe_store, only: %i[ show ]

  # Returns a shoe model and all of its available inventory
  #
  # @response_status 200
  # @response_class ShoeStoreSerializer
  def show
    respond_to do |format|
      format.html { render :show, status: :ok }
      format.json { render json: @shoe_store, status: :ok }
    end        
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe_store
      @shoe_store = ShoeStore.find(params[:id])
    end
    
end
