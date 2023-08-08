class Inventory < ApplicationRecord
  belongs_to :shoe_store
  belongs_to :shoe_model
end
