class Inventory < ApplicationRecord
  belongs_to :shoe_store
  belongs_to :shoe_model

  after_create_commit :broadcast_created_inventory
  after_update_commit :broadcast_updated_inventory


  def broadcast_created_inventory
    broadcast_append_later_to "inventory_global", partial: 'inventories/inventory', target: 'inventory_global_id'
    broadcast_append_later_to "inventory_store_#{self.shoe_store.id}", partial: 'inventories/inventory', target: self.shoe_store 
    broadcast_append_later_to "inventory_model_#{self.shoe_model.id}", partial: 'inventories/inventory', target: self.shoe_model 
  end

  def broadcast_updated_inventory
    broadcast_replace_later_to "inventory_global", partial: 'inventories/inventory'
    broadcast_replace_later_to "inventory_store_#{self.shoe_store.id}", partial: 'inventories/inventory'
    broadcast_replace_later_to "inventory_model_#{self.shoe_model.id}", partial: 'inventories/inventory'
  end  
end
