class ProductWithVariantProperty < ApplicationRecord
	belongs_to :productvariant
	belongs_to :variant_property
	validates :variant_property_id, uniqueness: true
end
