class ProductsController < ApplicationController
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])

    @query = Query.where(product_id: params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to home_index_path
    else
      flash[:danger] = 'Something went wrong.'
      render 'new'
    end
  end

  def add_to_cart
    cart = Cart.find_or_create_by(user_id: current_user.id)
    if cart.present?
      product = Product.find_by(id: params[:product_id])
      if cart.cart_items.find_by(product_id: product.id).present?
        flash[:message] = "Product is already in cart"
        redirect_to products_path
        return
      else
        # byebug
        # cart_item = cart.cart_items.new(product_id: product.id, cart_item_price: product.price, cart_item_quantity: 1)
        cart_item = cart.cart_items.new(product_id: product.id, cart_item_price: product.price, cart_item_quantity: 1)
        if cart_item.save
          flash[:harshita] = "Product added to cart..."
            redirect_to products_path
        else
          flash[:supriya] = "product not saved!!"  
        end
      end
    end
  end

  def like
    @like = Like.find_by(user_id: current_user.id , likeable_id: params[:product_id])
    if @like.present?
      flash[:message] = "Already liked"
      redirect_to products_path
    else
      @like = Like.create(user_id: current_user.id, likeable_id: params[:product_id], likeable_type:Product)
      flash[:message] = "Liked"
      redirect_to products_path
    end
  end

  def unlike
    liked = Like.all
    l = liked.where(likeable_id: params[:product_id])
    l.destroy_all
    redirect_to products_path
  end

  def qlike
    # byebug
    @p = Query.where(id: params[:product_id],user_id: current_user.id).pluck(:product_id)
    @q = Query.find_by(id: params[:product_id],user_id: current_user.id)
    if @q.likes.present?
      flash[:message] = "Already liked"
      redirect_to product_path(@p)
    else
      @like = Like.create(user_id: current_user.id, likeable_id: params[:product_id], likeable_type:Query)
      redirect_to product_path(@p)
    end
  end

  def qunlike
    @p = Query.where(id: params[:product_id],user_id: current_user.id).pluck(:product_id)
    @like = Like.where(user_id: current_user.id,likeable_type: "Query", likeable_id: params[:product_id])
    @like.destroy_all
    redirect_to product_path(@p)
  end

  private
  def product_params
    params.require(:product).permit(:name,:image)
  end

end
