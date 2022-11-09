class CategoriesController < ApplicationController
  
  def index
     @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash[:danger] = 'Something went wrong.'
      render 'new'
    end
  end

  def update
  end

  def destroy
    @categories = Category.find(params[:id])
    @categories.destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
