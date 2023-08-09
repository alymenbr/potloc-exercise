require 'rails_helper'

RSpec.describe "inventories/index", type: :view do
  fixtures :shoe_stores, :shoe_models

  before(:each) do
    assign(:inventories, [
      Inventory.create!({shoe_store: shoe_stores(:one), shoe_model: shoe_models(:one), quantity: 10}),
      Inventory.create!({shoe_store: shoe_stores(:two ), shoe_model: shoe_models(:two), quantity: 10})
    ])
  end

  it "renders a list of inventories" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
