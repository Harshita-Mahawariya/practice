module Api
  module V1
    class OrdersController < ApiController
      before_action :authenticate_user!
      respond_to :js, :json, :html
      Razorpay.setup('rzp_test_sGKFWWIENwCHjV', 'EX65NY1GAg5e6mTzJGJmoBE6')

    	def create
        cart = current_user.cart
        if cart.present? and cart.cart_items.present?
        	@order = current_user.orders.new(amount: cart.cart_price, status: "created", ordered_on: Time.now, address_id: params[:address_id].to_i)
        	cart.cart_items.each do |orderitem|
            @order_item = @order.order_items.new(product_id: orderitem.product_id, total_price: orderitem.cart_item_price, product_quantity: orderitem.cart_item_quantity)
            @order_item.save
          end
          if @order.save
            order = Razorpay::Order.create amount: @order.amount*100, currency: 'INR', receipt: 'TEST'
            @order.update(razorpay_order_id: order.id, status: "created")
            render json: {message: "Order created successfully"}
          end
          cart.cart_items.destroy_all
        else
          render json: {message: "Can not be done, try again !!"}
        end
      end

      def index
       	@order = current_user&.orders
       	@order_item = current_user&.order_items
        render json: {Order: @order, Order_Item: @order_item, status: :ok}
      end

      def update
        order = Order.find_by(id: params[:id])
        if order.present?
          order.update(razorpay_payment_id: params[:razorpay_payment_id], status: "payment_completed")
          render json: {message:"Successfully updated"}
        end
      end

      def show
        @orders = current_user.orders.where(id: params[:id])
        @oit = OrderItem.where(order_id: params[:id])
        render json: {Order: @orders, Order_Item:@oit, status: :ok}
      end

    end
  end
end