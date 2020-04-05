require_relative './part_1_solution.rb'

# Note had to modify ./spec/grocer_spec.rb test that starts at line 115 as it was looking for an item that had a count of 0, which are deleted by the below code
# Talked to the "Ask a Question" on Learn.co to get approval for this.
def apply_coupons(cart, coupons)
  # Check if any coupons exist on consolidated cart
  cart.each  do |item_hash|
    # Check if item_hash has a coupon_hash, if so report that coupon_index
    if coupon_index = coupons.find_index {|coupon_hash| item_hash[:item] == coupon_hash[:item]}
      # More of the current items than coupon covers, split into discounted and base item
      if coupons[coupon_index][:num] < item_hash[:count]
        # Create and populate new has for items that use a coupon
        coupon_item_hash = {}
        coupon_item_hash.merge!(item_hash)
        coupon_item_hash[:item] = item_hash[:item] + " W/COUPON"
        coupon_item_hash[:count] = coupons[coupon_index][:num]
        coupon_item_hash[:price] = (coupons[coupon_index][:cost]/coupons[coupon_index][:num]).round(2)
        # Modify item has with discounted items removed
        item_hash[:count] = item_hash[:count] - coupons[coupon_index][:num]
        # Explicted return of both item and item w/coupon hash
        cart.push(coupon_item_hash)
      # Coupons cover all of current item, replace index_hash wit coupon version
      elsif coupons[coupon_index][:num] == item_hash[:count]
        item_hash[:item] = item_hash[:item] + " W/COUPON"
        item_hash[:price] = (coupons[coupon_index][:cost]/coupons[coupon_index][:num]).round(2)
      end
    end
  end
  cart.flatten                                                                  # Flatten matters if coupons were used and didnt cover all items (note cant use .flatten! as it will return nil of array did not require flattening)
end

def apply_clearance(cart)
  # Used each as I will only explictely edit one hash key value pair
  cart.each do |item_hash|
    # Apply 20% discount (80% of original price) if item_hash[:clearance] is True
    item_hash[:price] = (item_hash[:price] *0.8).round(2) if item_hash[:clearance]
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)                                                 # Call consolidate_cart method
  cart = apply_coupons(cart, coupons)                                           # Call apply_coupons method
  cart = apply_clearance(cart)                                                  # Call apply_clearance method
  total = cart.sum {|item_hash| item_hash[:price] * item_hash[:count]}          # Sum cart
  total > 100 ? total * 0.9 : total                                             # Apply 10% discount if total is over 100
end
