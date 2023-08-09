require "rails_helper"

RSpec.describe ShoeStoresController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/shoe_stores/1").to route_to("shoe_stores#show", id: "1")
    end
  end
end
