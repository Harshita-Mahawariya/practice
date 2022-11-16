module Api
  module V1
		class ProductWithVariantPropertySerializer < ActiveModel::Serializer
			attributes :variant_name, :variant_property_name
			
			def variant_name
				# byebug
				VariantProperty.find_by_id(object.variant_property_id).variant.name
			end

			def variant_property_name
				VariantProperty.find_by_id(object.variant_property_id).name
			end
		
		end
	end
end