module Api
  module V1
		class ProductSerializer < ActiveModel::Serializer
			attributes :id,:price,:name,:quantity, :product_variant
			attribute :image do |object|
				Rails.application.routes.url_helpers.rails_blob_url(object.object.image) if object.object.image.attached?
			end

			def product_variant
	        ActiveModel::SerializableResource.new(object.productvariants,  each_serializer: Api::V1::ProductvariantSerializer)
	    end

			# attribute :product_variants do |object|
			# 	# byebug
			# 	result = []
			# 	res = []
			# 	object.object.productvariants.each do |pv|
			# 		pv.product_with_variant_properties.each do |pvp|
			# 			var_prop = VariantProperty.find_by_id(pvp.variant_property_id)
			# 			res << {variant: var_prop.variant.name, variant_property: var_prop.name}
			# 		end
			# 		result << {name: pv.name, price: pv.price, place: pv.place, variant_properties: res}
			# 	end
			# 	result
			# end

		end
	end
end