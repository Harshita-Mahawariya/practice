module Api
  module V1
    class CartsController < ApiController
      before_action :authenticate_user!
    	
      def index
        # byebug
        @cart = current_user.cart
        render json: {Cart: @cart, status: :ok}
      end

      def show
        if Cart.find_by_id(params[:id]).present?
          @cart = Cart.find(params[:id])
          @cart_item = current_user.cart.cart_items
          @addresses = current_user.addresses
          render json: {Cart: @cart, Cart_Item:@cart_item, Address:@addresses, status: :ok}
        else
          render json: {message: "cart for this id could not be found"}
        end
      end

      def cart_item_destroy
        byebug
        if current_user.cart.cart_items.find_by(id: params[:id]).present?
          @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
          @cart_item.destroy
          render json: {message: "Deleted successfully", status: :ok}
        else
           render json: {message: "Cart Item for this id could not be found"}
        end
      end

      def update_cart
        if CartItem.find_by(id: params[:id]).present?
          cart_item = CartItem.find_by(id: params[:id])
          cart_i_p = cart_item.product.price
          up_quantity = cart_item.update(cart_item_quantity: params[:cart_item_quantity].to_i, cart_item_price: cart_i_p)
          render json: {message: "Updated successfully"}
        else
          render json: {message: "Cart and Cart item not found"}
        end
      end

      private
      def cart_itm_params
        params.require(:cart).permit(:cart_item_price, :product_id, :cart_item_quantity, :_destroy, :cart_id, :cart_price, :cart_id)
      end

    end
  end
end
