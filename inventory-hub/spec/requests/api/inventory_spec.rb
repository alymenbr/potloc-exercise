require 'rails_helper'

RSpec.describe "Api::Inventories", type: :request do
  describe "POST /create" do

    context 'with valid parameters' do
      fixtures :shoe_stores, :shoe_models
      let(:store1) { shoe_stores(:one) }      
      let(:model1) { shoe_models(:one) }     
      let(:new_params) { {"store": "new_store", "model": "new_model", inventory: 10} }  

      it 'updates inventory for a new store and model' do
        post '/api/inventory', params: new_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(:created)
      end

      it 'updates inventory for an existing store' do
        params = new_params.merge( {store: store1.name} )
        post '/api/inventory', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:created)
        expect(json["shoe_store"]["id"]).to eq(store1.id)
      end

      it 'updates inventory for an existing model' do
        params = new_params.merge( {model: model1.name } )
        post '/api/inventory', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:created)
        expect(json["shoe_model"]["id"]).to eq(model1.id)
      end      

      it 'updates inventory for an existing model and store' do
        params = new_params.merge( {store: store1.name, model: model1.name} )
        post '/api/inventory', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:created)
        expect(json["shoe_store"]["id"]).to eq(store1.id)
        expect(json["shoe_model"]["id"]).to eq(model1.id)
      end           

      it 'when succeeding, responds with a correctly updated quantity' do
        post '/api/inventory', params: :new_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(json["quantity"]).to eq(new_params["inventory"])
      end
    end

    context 'with invalid parameters' do    
      it 'for a malformed request, returns an unprocessable entity status' do
        invalid_params = {"any": "unknown field here"}
        post '/api/inventory', params: invalid_params, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'for an invalid quantity, returns an unprocessable entity status' do
        invalid_params = {"store": "new_store", "model": "new_model", inventory: "not a number"}
        post '/api/inventory', params: invalid_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'for a negative quantity, returns an unprocessable entity status' do
        invalid_params = {"store": "new_store", "model": "new_model", inventory: -10}
        post '/api/inventory', params: invalid_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
      end      
    end
  end
end
