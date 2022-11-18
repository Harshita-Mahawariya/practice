class ProductWithVariantProperty < ApplicationRecord
	belongs_to :productvariant
	belongs_to :variant_property
	validates :productvariant_id, uniqueness: { scope: :variant_property_id}

	#validates_uniqueness_of :variant_property_id, scope: :productvariant_id

	# validate :validate_vp_id

	# def validate_vp_id
		
	#      errors.add(:variant_property_id, 'Name has already been taken')
	 
	# end

end