require 'rails_helper'

RSpec.describe InventoriesChannel, type: :channel do
  
  it "subscribes to the channel without providing a specific model or store stream" do
    subscribe
    expect(subscription).to be_confirmed
  end

  it "subscribes to the channel when providing a specific model stream" do
    subscribe(shoe_store_id: 1)

    expect(subscription).to be_confirmed
    expect(streams).to include("shoe_store_1")
  end

  it "subscribes to the channel when providing a specific model stream" do
    subscribe(shoe_model_id: 1)

    expect(subscription).to be_confirmed
    expect(streams).to include("shoe_model_1")
  end  


  TENTAR CRIAR STREAMS DE ACORDO COM shoe_store_id e shoe_model_id

end
