class CartsController < ApplicationController

	def index
    @cart = current_user.cart
    @cart_item = current_user.cart.cart_items
    @addresses = current_user.addresses
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def cart_item_destroy
    if current_user.cart.cart_items.find_by(id: params[:cart_id]).present?
      @cart_item = current_user.cart.cart_items.find_by(id: params[:cart_id])
      @cart_item.destroy
    else
      redirect_to carts_path
    end
  end

  def update_cart
    cart_item = CartItem.find_by(id: params[:cart_id])
    cart_i_p = cart_item.product.price
    up_quantity = cart_item.update(cart_item_quantity: params[:cart_item_quantity].to_i, cart_item_price: cart_i_p)
    redirect_to carts_path
  end

  private
  def cart_item_params
    params.require(:cart).permit(:cart_item_price, :product_id, :cart_item_quantity, :_destroy, :cart_id, :cart_price, :cart_id)
  end

end