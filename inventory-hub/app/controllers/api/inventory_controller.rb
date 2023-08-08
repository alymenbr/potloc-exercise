class Api::InventoryController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    params.require([:store, :model, :inventory])
    inventory_params = parse_create_params(request.body.read)

    inventory = nil
    Inventory.transaction do
      store = ShoeStore.where(name: inventory_params[:store_name]).first
      store = ShoeStore.create(name: inventory_params[:store_name]) if store.blank?
      
      model = ShoeModel.where(name: inventory_params[:model_name]).first
      model = ShoeModel.create(name: inventory_params[:model_name]) if model.blank?
  
      inventory = Inventory.where(shoe_store: store, shoe_model: model).first
      if inventory.present?
        inventory.update(quantity: inventory_params[:quantity])
      else
        inventory = Inventory.create(shoe_store: store, shoe_model: model, quantity: inventory_params[:quantity])
      end
    end

    if inventory.valid?
      render json: inventory.as_json, status: :created
    else
      render json: {error: inventory.errors}, status: :unprocessable_entity
    end

    rescue => e
      render json: {error: e}, status: :unprocessable_entity
  end

  private 
    def parse_create_params(body)
      json_params = JSON.parse( request.body.read)
      
      result = {}
      result[:store_name] = json_params["store"]
      result[:model_name] = json_params["model"]
      result[:quantity] = Integer(json_params["inventory"])

      throw "Inventory quantity must be a positive number" if result[:quantity] < 0
      result
    end
end
