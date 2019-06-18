def consolidate_cart(cart)
 consolidated_cart = {}
  cart.each do |item|
    if consolidated_cart[item.keys[0]]
      consolidated_cart[item.keys[0]][:count] += 1
    else
      consolidated_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    #if any keys in the cart match items on the coupon 
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        couponed_item = "#{coupon[:item]} W/COUPON"
        if cart[couponed_item]
          cart[couponed_item][:count] += coupon[:num]
        else
          cart[couponed_item] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end
  end
  cart
end


def checkout(cart)
  consolidated_cart = consolidate_cart(cart) 
  couponed_cart = apply_coupons(consolidated_cart)
  discounted_cart = apply_clearance(couponed_cart)
  
  total = 0.00
  discounted_cart.keys.each do |item|
    total += discounted_cart[item][:price]*discounted_cart[item][:count]
  end 
  total > 100 ? 
  
  
end 
