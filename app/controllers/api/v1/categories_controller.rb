module Api
  module V1
    class CategoriesController < ApiController
      # respond_to :json
      before_action :authenticate_user!

      def index
        @categories = Category.all
        render json: {result: @categories}, status: :ok
      end

      def show
        @category = Category.find(params[:id])
        render json: {result: @category}, status: :ok
      end
      
      def create
        # byebug
        @category = Category.new(cat_params)
        if @category.save
          render json: {result: @category,  message: " Category Created"}
        else
          render json: { message: "Category Not Created"}
        end
      end

      def update
        @category = Category.find_by_id(params[:id])
        if @category.update(cat_params)
          render json: {result: @category}, status: :ok
        else
          render json: { errors: @category.errors.full_messages },
               status: :unprocessable_entity
        end
      end

      def destroy
        @categories = Category.find(params[:id])
        @categories.destroy

        render json: { message: "Successfully deleted"}
      end

      private

      def cat_params
        # byebug
        # params.permit(:name, :id)
          params.require(:category).permit(:name) 
          # pass category[name] in postman for creation
      end
    end
  end
end
