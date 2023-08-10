# @tag ShoeModelsController
# API for availability of a specific shoe model.
class ShoeModelsController < ApplicationController
  before_action :set_shoe_model, only: %i[ show ]

  # Returns a shoe model and all of its available inventory
  #
  # @response_status 200
  # @response_class ShoeModelSerializer
  def show
    respond_to do |format|
      format.html { render :show, status: :ok }
      format.json { render json: @shoe_model, status: :ok }
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe_model
      @shoe_model = ShoeModel.find(params[:id])
    end
    
end
