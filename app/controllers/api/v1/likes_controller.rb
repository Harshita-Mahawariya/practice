module Api
	module V1
		class LikesController < ApiController
			before_action :authenticate_user!
			
			def index
				@liked = Like.where(likeable_type: "Product").pluck(:likeable_id).uniq
				@p = Product.where(id: @liked)
				render json: {Liked_Product: @p , status: :ok }
			end

			def like
		    @like = Like.find_by(user_id: current_user.id , likeable_id: params[:id])
		    @product = Product.find_by_id(params[:id])
		    if @like.present?
		      render json: {message:"Already liked" , Product: @product}
		    else
		      @like = Like.create(user_id: current_user.id, likeable_id: params[:product_id], likeable_type:Product)
		      @product = Product.find_by_id(params[:id])
		      render json: {message: "Liked" , Product: @product}
		    end
		  end

			def unlike
				liked = Like.all
				like = liked.where(likeable_id: params[:id])
				@product = Product.find_by_id(params[:id])
				like.destroy_all
				render json: {message: "Unliked" , Product: @product}
			end

			def Qlike
		    @like = Like.find_by(user_id: current_user.id , likeable_id: params[:id])
		    @query = Query.find_by_id(params[:id])
		    if @like.present?
		      render json: {message:"Already liked" , Query: @query}
		    else
		      @like = Like.create(user_id: current_user.id, likeable_id: params[:id], likeable_type:Query)
		      @query = Query.find_by_id(params[:id])
		      render json: {message: "Liked" , Query: @query}
		    end
		  end

			def Qunlike
				liked = Like.all
				like = liked.find_by(likeable_id: params[:id])
				@query = Query.find_by_id(params[:id])
				like.destroy
				render json: {message: "Unliked" , Query: @query}
			end

		end
	end
end