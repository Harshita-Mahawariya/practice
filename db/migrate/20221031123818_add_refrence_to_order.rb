class AddRefrenceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :address, null: false, foreign_key: true
    add_column :orders, :razorpay_order_id, :string
    add_column :orders, :razorpay_payment_id, :string
  end
end
