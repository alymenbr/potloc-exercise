require 'rails_helper'

RSpec.describe InventoriesChannel, type: :channel do
  
  it "subscribes to the channel successfully" do
    subscribe
    expect(subscription).to be_confirmed
  end

end
