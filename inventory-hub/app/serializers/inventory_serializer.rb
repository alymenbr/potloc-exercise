# @attr [integer] id
# @attr [ShoeStoreSerializer] shoe_store
# @attr [ModelStoreSerializer] show_model
# @attr [integer] quantity
class InventorySerializer < ActiveModel::Serializer
  attributes :id, :quantity
  has_one :shoe_store
  has_one :shoe_model
end
