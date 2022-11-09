class Order < ApplicationRecord
	belongs_to :user
  # has_many :products, through: :order_items
  has_many :order_items, dependent: :destroy
  before_create :create_order_no
  belongs_to :address
  enum status: [ :created ,:payment_completed ]

  def create_order_no
    order_number = create_new_order_no
    self.order_no = order_number
  end

  def create_new_order_no
    orders = Order.all
    if orders.present?
      if orders&.last&.order_no&.include?("ORDN-")
        orders&.last&.order_no&.succ
      else
        format('ORDN-%05d', 0)
      end
    else
      format('ORDN-%05d', 0)
    end
  end

end
