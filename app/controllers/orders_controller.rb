class OrdersController < ApplicationController

  respond_to :js, :json, :html
  Razorpay.setup('rzp_test_sGKFWWIENwCHjV', 'EX65NY1GAg5e6mTzJGJmoBE6')

	def create_order
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
        redirect_to pay_order_path(@order.id)
      end
      #redirect_to orders_path
      cart.cart_items.destroy_all
      return
    else
      redirect_to carts_path
    end
  end

  def index
   	@order = current_user&.orders
   	@order_item = current_user&.order_items
  end

  def pay
    @order = Order.find_by(id: params[:id])
    @cart = current_user.cart
  end

  def update
    order = Order.find_by(id: params[:id])
    if order.present?
       payment_response = {razorpay_order_id: params[:razorpay_order_id], razorpay_payment_id: params[:razorpay_payment_id], razorpay_signature: params[:razorpay_signature] }
       verify_result = Razorpay::Utility.verify_payment_signature(payment_response)
       if verify_result
          order.update(razorpay_payment_id: params[:razorpay_payment_id], status: "payment_completed")
       else
          flash[:error] = "something went wrong!!!" 
          redirect_to orders_path
       end
    end
   end

  def details
    @orders = current_user.orders
    @oid = OrderItem.where.not(id: params[:id])
    @oi = OrderItem.where(id: params[:id])
  end

	private
  def cart_params
    params.require(:cart).permit(:cart_price, :cart_quantity, :_destroy, :product_id)
  end
  def order_params
    params.require(:order).permit(:id ,:order_no, :status ,:ordered_on, :address_id, :razorpay_order_id)
  end

end
