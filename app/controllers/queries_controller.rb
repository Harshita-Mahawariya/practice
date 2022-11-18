class QueriesController < ApplicationController

	def new
		@query = current_user.queries.new
	end

	def create
    @query = current_user.queries.new(query_params)
    if @query.save
    	@product = Product.find_by(id: query_params[:product_id])
      redirect_to product_path(@product)
    else
      flash[:danger] = 'Something went wrong.'
    end
  end

  def destroy
  	query = Query.find_by_id(params[:id])
  	@product = query.product_id
  	query.destroy
  	redirect_to product_path(@product)
  end

	private
	def query_params
		params.require(:query).permit(:description, :user_id, :product_id, :answer_id)
	end

end
