class Categories::SubcategoriesController < ApplicationController

  before_action :authenticate_admin!, except: :show

  def show
    @category = Category.friendly.find(params[:category_id])
    @subcategory = Subcategory.friendly.find(params[:id])
    @subcategories = @category.subcategories
    @videos = @subcategory.videos
  end

  def new
    @category = Category.friendly.find(params[:category_id])
    @subcategory = Subcategory.new
  end

  def create
    @category = Category.friendly.find(params[:category_id])
    @subcategory = @category.subcategories.build(subcategory_params)
    if @subcategory.save
      flash[:notice] = "You just created " + @subcategory.title + "!"
      redirect_to category_subcategory_path(@category, @subcategory)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @category = Category.friendly.find(params[:category_id])
    @subcategory = Subcategory.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:category_id])
    @subcategory = Subcategory.friendly.find(params[:id])
    if @subcategory.update_attributes(subcategory_params)
      flash[:notice] = "Good job!"
      redirect_to category_subcategory_path(@category, @subcategory)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @category = Category.friendly.find(params[:category_id])
    @subcategory = Subcategory.friendly.find(params[:id]).destroy
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

    def subcategory_params
      params.require(:subcategory).permit(:title, :description, :image)
    end

end