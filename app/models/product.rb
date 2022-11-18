class Product < ApplicationRecord
	include ActiveStorageSupport::SupportForBase64
	include ActiveStorage::Blob::Analyzable

  	has_one_base64_attached :image

	belongs_to :category, optional: true
	# has_one_attached :image
	has_many :productvariants, dependent: :destroy
	has_many :cart_items, dependent: :destroy
	has_many :carts, through: :cart_items 
	has_many :order_items, dependent: :destroy
	has_many :orders, through: :order_items
	has_many :queries ,dependent: :destroy
	has_many :likes, as: :likeable,dependent: :destroy
	
	validates :name, presence: true, uniqueness: {scope: :category_id},format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters..." }
	#validates :price, numericality: true, length: { maximum: 5}
	#validates :quantity, numericality: true, allow_blank: true 
	accepts_nested_attributes_for :productvariants, allow_destroy: true
	accepts_nested_attributes_for :queries, allow_destroy: true

	# before_save :duplicate_product_variant #, on: :update


	# def duplicate
	# 	self.productvariants.pluck(:name).each do |pd|
	# 		if Productvariant.all.pluck(:name).include?(pd)
	# 			self.errors.add(:productvariants, "Product Variants can't be same")
	# 		end
	# 	end
	# end


	# def dup
	# 	byebug
	# 	self.productvariants.each do |item|
	# 		if Productvariant.all.pluck(:name).include?(self.productvariant.pluck(:name))
	# 			self.errors.add(:productvariants, "Product Variants can't be same")
	# 		end 
	# 	end
	# end
end
