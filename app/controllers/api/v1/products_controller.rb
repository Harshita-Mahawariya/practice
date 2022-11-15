module Api
  module V1
    class ProductsController < ApiController
      before_action :authenticate_user!
      def index
        @products = Product.all
        render json: {result:@products, status: :ok}
      end

      def show
        @product = Product.find_by(id: params[:id])
        render json: {result: @product, status: :ok}
        # @query = Query.where(product_id: params[:id])
      end

      def create
        @product = Product.new(pro_params)
        # @product.image = params[:product][:image]
        # @product.image.attach(data: params[:product][:image])
        if @product.save
          render json: {result: ActiveModelSerializers::SerializableResource.new(@product, serializer: ProductSerializer), message: "Successfully Created"}
        else
          render json: {message: "Something went wrong"}
        end
      end

      def destroy
        @product = Product.find_by_id(params[:id])
        @product.destroy
        render json: {message:"Successfully deleted"}
      end

      private
      def pro_params
        # params.require(:product).permit(:category_id, :name, :price, :quantity, :image)
        params.require(:product).permit!
      end

    end
  end
end
