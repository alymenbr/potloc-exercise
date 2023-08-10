module ApplicationHelper

  # Order primarily by store, then by model
  def inventory_order(primary_string, secondary_string)
    (primary_string.to_s.sum)**2 + secondary_string.to_s.sum
  end

   # Adds class to show animation when entering the DOM if variable is true
   def animated_highlight_on(variable)
    'item-highlight' if variable
  end 
end
