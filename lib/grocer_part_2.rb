require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do | items |
    coupons.each do | coupon_items |
      if coupon_items[:item] == items[:item]
        if items[:count] > coupon_items[:num] - 1
          items[:count] = items[:count] - coupon_items[:num]
          cart << {
          :item => "#{items[:item]} W/COUPON",
          :price => coupon_items[:cost] / coupon_items[:num].to_f,
          :clearance => items[:clearance],
          :count => coupon_items[:num]
          }
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do | items |
    if items[:clearance] == true 
      items[:price] = (items[:price].to_f * 0.80).round(2)
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  price = []
  clearanced_cart.each do | items |
    price << (items[:price] * items[:count])
  end
  sum = 0 
  price.each do | i |
    sum += i
  end
  if sum > 100
    return (sum * 0.90)
  end
  return sum
end
