class Productvariant < ApplicationRecord
	belongs_to :product
	validates :name, presence: true, uniqueness: {scope: :product_id}
	# validates :price,presence: true , numericality: {only_integer: true}
	# validates :stock_quantity,presence: true , numericality: {only_integer: true}
	has_many :product_with_variant_properties ,dependent: :destroy
	has_many :variant_properties, :through => :product_with_variant_properties
	
	accepts_nested_attributes_for :product_with_variant_properties ,allow_destroy: true

	# after_create do
	# 	price = self.price + self.price / 10
	# 	self.update(price: price)
	# end
	
	# before_create do
	# 	arr = self.product_with_variant_properties.map.pluck(:variant_property_id)
	# 	# byebug
	# 	if arr.uniq.count < arr.count
	# 		self.errors.add(:variant_property_id, 'Name has already been taken')
	# 	end
	# end
end