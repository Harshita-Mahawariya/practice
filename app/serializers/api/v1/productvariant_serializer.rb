module Api
  module V1
		class ProductvariantSerializer < ActiveModel::Serializer
			attributes :id,:price,:name,:stock_quantity, :product_with_variant_properties
			
			def product_with_variant_properties
				ActiveModel::SerializableResource.new(object.product_with_variant_properties,  each_serializer: Api::V1::ProductWithVariantPropertySerializer)
			end

		end
	end
end