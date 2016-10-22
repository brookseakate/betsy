class CategoriesController < ApplicationController
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
