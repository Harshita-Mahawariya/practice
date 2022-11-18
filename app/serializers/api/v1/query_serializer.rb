module Api
  module V1
		class QuerySerializer < ActiveModel::Serializer
			attributes :description, :reply

			def reply
				ActiveModel::SerializableResource.new(object.replies,  each_serializer: Api::V1::ReplySerializer)
			end

		end
	end
end