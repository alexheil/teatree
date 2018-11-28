class Users::VideosController < ApplicationController

  before_action :authenticate_user!, except: [:show, :search]
  before_action :correct_user, only: [:new, :create]
  before_action :correct_video_user, only: [:edit, :update, :destroy]
  before_action :set_user, except: [:show, :search]
  before_action :banned, only: [:new, :create]
  before_action :member, only: [:new, :create]

  def search
    @videos = Video.search(params[:search]).order("view_count DESC").page params[:page]
  end

  def show
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:id])
    @videos = @user.videos.newest.limit(10)
    @comment = Comment.new
    @add = Add.new
    if @video.free? || (user_signed_in? && (current_user.subscribing?(@user)) || (current_user == @user))
      impressionist(@video)
    end
  end

  def new
    @video = Video.new
  end

  def create
    @video = @user.videos.build(video_params)
    if @video.save
      flash[:notice] = "You just created " + @video.title + "!"
      redirect_to user_video_path(@user, @video)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @video = Video.friendly.find(params[:id])
  end

  def update
    @video = Video.friendly.find(params[:id])
    if @video.update_attributes(video_params)
      flash[:notice] = "You just updated " + @video.title + "!"
      redirect_to user_video_path(@user, @video)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      redirect_to root_url
    end
  end

  def destroy
    @video = Video.friendly.find(params[:id]).destroy
    redirect_to user_path(@user)
  end

  private

    def video_params
      params.require(:video).permit(:subcategory_id, :category_id, :title, :description, :image, :remove_image, :video, :remove_video, :policy_type, :duration)
    end

    def set_user
      @user = current_user
    end

    def member
      @user = current_user
      if current_user.membership.blank?
        redirect_to new_user_membership_path(@user)
        flash[:alert] = "You need to be a member before you can upload a video."
      end
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not your profile."
      end
    end

    def correct_video_user
      @video = Video.friendly.find(params[:id])
      redirect_to user_path(@video.user_id) if @video.user_id != current_user.id
    end

    def banned
      @user = current_user
      if @user.banned?
        redirect_to user_path(@user)
        flash[:alert] = "Your account has been banned."
      end
    end

end
