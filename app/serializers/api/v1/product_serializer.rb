module Api
  module V1
		class ProductSerializer < ActiveModel::Serializer
			attributes :id,:price,:name,:quantity
			attribute :image do |object|
				# byebug
				Rails.application.routes.url_helpers.rails_blob_url(object.object.image) if object.object.image.attached?
			end
		end
	end
end