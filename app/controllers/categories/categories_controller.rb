class Categories::CategoriesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.friendly.find(params[:id])
    @subcategories = @category.subcategories
    @videos = @category.videos
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "You just created " + @category.title + "!"
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = "Good job!"
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @category = Category.friendly.find(params[:id]).destroy
    redirect_to root_url
    flash[:notice] = "Delete successful."
  end

  private

    def authenticate_admin!
      unless user_signed_in? && current_user == User.find(1)
        redirect_to root_url
        flash[:notice] = "You do not have access to this page."
      end
    end

    def category_params
      params.require(:category).permit(:title, :description, :image)
    end

end