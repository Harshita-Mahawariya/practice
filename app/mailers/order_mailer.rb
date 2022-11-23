class OrderMailer < ApplicationMailer
	default from: 'notifications@basketship.com'
  def Order_confirmed order
  	# byebug
  	@order = order
  	@user = order.user
  	@url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Order confirmed").attachments["orders_#{@order.id}.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(template: '/orders/invoice.html.erb', layout: false))
  end
end
