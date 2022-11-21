class Refund
	require "razorpay"
	Razorpay.setup('rzp_test_sGKFWWIENwCHjV', 'EX65NY1GAg5e6mTzJGJmoBE6')

	 # attr_accessor :order

	def initialize order
		# byebug
		@order = order
	end

	def refund
		# byebug
		paymentId = @order.razorpay_payment_id 

		para_attr = {
		  "amount": @order.amount,
		  "speed": "normal"
		}
		response = Razorpay::Payment.fetch(paymentId).refund(para_attr) 
	end
end
