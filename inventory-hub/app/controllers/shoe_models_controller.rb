class ShoeModelsController < ApplicationController
  before_action :set_shoe_model, only: %i[ show ]

  # GET /shoe_models/1 or /shoe_models/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoe_model
      @shoe_model = ShoeModel.find(params[:id])
    end
    
end
