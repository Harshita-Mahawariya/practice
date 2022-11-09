ActiveAdmin.register CartItem do

  permit_params :cart_item_price, :cart_item_quantity, :cart_id, :product_id
  menu false
  
end
