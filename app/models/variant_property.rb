class VariantProperty < ApplicationRecord
	belongs_to :variant, optional: true
	validates :name, uniqueness: {scope: :variant_id}
	has_many :product_with_variant_properties, dependent: :destroy
	has_many :productvariants, :through => :product_with_variant_properties
	accepts_nested_attributes_for :product_with_variant_properties ,allow_destroy: true
end
