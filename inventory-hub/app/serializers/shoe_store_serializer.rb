# @attr [integer] id
# @attr [string] name
# @attr [Array<InventorySerializer>] inventories
class ShoeStoreSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :inventories
end
