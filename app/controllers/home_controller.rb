class HomeController < ApplicationController

  def index
    @products = Product.first(14)
  end

  private
  def product_params
    params.require(:product).permit(:name,:image)
  end

end
