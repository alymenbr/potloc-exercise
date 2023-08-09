class InventoriesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "inventories"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
