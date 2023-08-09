module ApplicationHelper

  # Order primarily by store, then by model
  def inventory_order(primary_string, secondary_string)
    (primary_string.to_s.sum)**2 + secondary_string.to_s.sum
  end
end
