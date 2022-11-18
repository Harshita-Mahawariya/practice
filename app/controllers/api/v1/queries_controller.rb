module Api
	module V1
		class QueriesController < ApiController
			before_action :authenticate_user!
		  
		  def index
		  	@queries = Query.all
		  	render json: {Query: @queries, status: :ok}
		  end

		  def show
		  	query = Query.where(id: params[:id])
		  	@query= query.pluck(:description)
		  	@product = Product.where(id: query.pluck(:product_id)).pluck(:name)
		  	@answer = Query.where(answer_id: params[:id]).pluck(:description)
		  	render json: { Product:@product, Query: @query,Answer: @answer , status: :ok}
		  end

			def create
		    @query = current_user.queries.new(query_params)
		    if @query.save
		    	@product = Product.find_by(id: query_params[:product_id])
		      render json: {Product: @product, Query: @query , message: "Query created successfully"}
		    else
		      render json: {message: 'Something went wrong.'}
		    end
		  end

		  private
			def query_params
				params.require(:query).permit(:description, :user_id, :product_id, :answer_id)
			end
		end
	end
end