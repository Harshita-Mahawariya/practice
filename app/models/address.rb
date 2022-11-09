class Address < ApplicationRecord
	belongs_to :user
	has_many :orders
	validates :house_no, presence: true, numericality: {only_integer: true}
	validates :pincode, presence: true, numericality: {only_integer: true}, length: { is: 6,message:"only 6 integer allowed" }
	validates :city, :state, :area_or_colony, presence: true
end
