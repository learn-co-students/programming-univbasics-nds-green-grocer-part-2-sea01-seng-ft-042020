def find_item_by_name_in_collection(name, collection)
  # Iterate through collection with find enumerable to match first :item == name
  collection.find {|item_hash| item_hash[:item] == name}
end

def consolidate_cart(cart)
  # Create a cart of only unique items and then start to remape it to add item count
  cart.uniq.each do |uniq_item_hash|
    # Using new unique items count the number of times in cart
    item_count = cart.count {|cart_item_hash| cart_item_hash == uniq_item_hash}
    # Via map merge the existing uniq_item_hash with a new count hash
    uniq_item_hash.merge!({:count => item_count})
  end
end
