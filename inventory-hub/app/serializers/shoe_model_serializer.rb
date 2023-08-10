# @attr [integer] id
# @attr [string] name
# @attr [Array<InventorySerializer>] inventories
class ShoeModelSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :inventories
end
