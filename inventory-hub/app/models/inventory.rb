class Inventory < ApplicationRecord
  belongs_to :shoe_store
  belongs_to :shoe_model

  after_create_commit :broadcast_created_inventory
  after_update_commit :broadcast_updated_inventory


  def broadcast_created_inventory
    broadcast_append_later_to "inventory_global", partial: 'inventories/inventory', target: 'inventory_global_id', locals: {inventory: self, created: true, updated: false}
    broadcast_append_later_to "inventory_store_#{self.shoe_store.id}", partial: 'inventories/inventory', target: self.shoe_store, locals: {inventory: self, created: true, updated: false}
    broadcast_append_later_to "inventory_model_#{self.shoe_model.id}", partial: 'inventories/inventory', target: self.shoe_model, locals: {inventory: self, created: true, updated: false}
  end

  def broadcast_updated_inventory
    broadcast_replace_later_to "inventory_global", partial: 'inventories/inventory', locals: {inventory: self, created: false, updated: true}
    broadcast_replace_later_to "inventory_store_#{self.shoe_store.id}", partial: 'inventories/inventory', locals: {inventory: self, created: false, updated: true}
    broadcast_replace_later_to "inventory_model_#{self.shoe_model.id}", partial: 'inventories/inventory', locals: {inventory: self, created: false, updated: true}
  end  
end
