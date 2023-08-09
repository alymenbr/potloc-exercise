require 'rails_helper'

RSpec.describe "shoe_stores/show", type: :view do
  before(:each) do
    assign(:shoe_store, ShoeStore.create!({name: "Store 1"}))
  end

  it "renders attributes in <p>" do
    render
  end
end
