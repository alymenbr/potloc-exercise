require "rails_helper"

RSpec.describe InventoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/inventories").to route_to("inventories#index")
    end
  end
end
