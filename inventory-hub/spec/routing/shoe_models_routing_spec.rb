require "rails_helper"

RSpec.describe ShoeModelsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/shoe_models/1").to route_to("shoe_models#show", id: "1")
    end
  end
end
