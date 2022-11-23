class CartItem < ApplicationRecord
	belongs_to :cart
	belongs_to :product
	after_save :cart_price
	after_destroy :cart_price
    after_save :cart_price

  def cart_price
    cart_price = 0
    cart_quantity = 0
    self.cart.cart_items.each do |ci|
        unless ci.cart_item_price.nil? 
            cart_price += ci.cart_item_price.to_f * ci.cart_item_quantity
            cart_quantity += ci.cart_item_quantity
        end
    end     
    self.cart.update(cart_price: cart_price, cart_quantity: cart_quantity)
  end
end
