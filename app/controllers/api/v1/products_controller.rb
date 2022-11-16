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
      end

      def create
        # byebug
        @product = Product.new(pro_params)
        if @product.save
          #image base64 # render json: {result: ActiveModelSerializers::SerializableResource.new(@product,serializer: ProductSerializer),@productvariant, message: "Successfully Created"}
          render json: {data: serialized_product(@product),meta: {message:'Product Added successfully'}}
        else
          render json: {errors: @product.errors.full_messages}
        end
      end

      def serialized_product product
        Api::V1::ProductSerializer.new(product)
      end

      def destroy
        @product = Product.find_by_id(params[:id])
        @product.destroy
        render json: {message:"Successfully deleted"}
      end

      private
      def pro_params
        # byebug
        params.require(:product).permit(:name, :category_id,:price, productvariants_attributes: [:id, :name, :place, :price, :stock_quantity, :_destroy, product_with_variant_properties_attributes:[:id, :productvariant_id, :variant_property_id, :_destroy]])
        #image base 64# params.require(:product).permit!
      end

    end
  end
end
