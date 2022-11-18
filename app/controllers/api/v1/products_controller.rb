module Api
  module V1
    class ProductsController < ApiController
      before_action :authenticate_user!
      def index
        @products = Product.all
        render json: {result:@products, status: :ok}
      end

      def show
        @product = Product.find_by_id(params[:id])
        render json: {data: serialized_product(@product),meta: {message:'Product'}}
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

      def add_to_cart
        cart = Cart.find_or_create_by(user_id: current_user.id)
        if cart.present?
          product = Product.find_by(id: params[:product_id])
          if cart.cart_items.find_by(product_id: product.id).present?
            render json: {message:"Product is already in cart"}
          else
            cart_item = cart.cart_items.new(product_id: product.id, cart_item_price: product.price, cart_item_quantity: 1)
            if cart_item.save
              render json: {message: "Product added to cart..."}
            else
              render json: {message: "product not saved!!"}
            end
          end
        end
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
