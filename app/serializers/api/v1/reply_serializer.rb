module Api
  module V1
		class ReplySerializer < ActiveModel::Serializer
			
			attributes :description

		end
	end
end