class LikesController < ApplicationController

	def index
		@liked = Like.where(likeable_type: "Product").pluck(:likeable_id).uniq
		@p = Product.where(id: @liked)
	end

	def unlike
		liked = Like.all
		l = liked.where(likeable_id: params[:like_id])
		l.destroy_all
		redirect_to likes_path
	end

end
