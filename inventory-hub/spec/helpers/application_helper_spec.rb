require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the InventoriesHelper. For example:
#
# describe InventoriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "inventory_order usage" do
    context 'with valid parameters' do
      it "orders accordingly to the primary_string" do
        expect(helper.inventory_order('A', 'A')).to be < helper.inventory_order('B', 'A')
        expect(helper.inventory_order('A', 'A')).to be < helper.inventory_order('B', 'Z')
      end

      it "orders accordingly to the secondary_string if the primary_string is the same" do
        expect(helper.inventory_order('A', 'A')).to be < helper.inventory_order('A', 'B')
        expect(helper.inventory_order('A', 'A')).to be < helper.inventory_order('A', 'Z')        
      end

      it "orders in the way on consecutive calls" do
        expect(helper.inventory_order('A', 'A')).to eq( helper.inventory_order('A', 'A'))
      end      
    end

    context 'with invalid parameters' do
      it "orders invalid parameter first" do
        expect(helper.inventory_order('A', nil)).to be < helper.inventory_order('A', 'A')
        expect(helper.inventory_order(nil, 'A')).to be < helper.inventory_order('A', 'A')
        expect(helper.inventory_order(nil, nil)).to be < helper.inventory_order('A', 'A')
      end          
    end
  end
end
