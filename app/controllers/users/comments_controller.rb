class Users::CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, except: :create
  before_action :subscriber

  def create
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:video_id])
    @comment = @video.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = "You posted a comment on #{@video.title}."
      redirect_to user_video_path(@user, @video)
    else
      redirect_to (:back)
      flash[:alert] = "You failed."
    end
  end

  def update
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:video_id])
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:notice] = "You updated your comment on #{@video.title}!"
      redirect_to user_video_path(@user, @video)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:video_id])
    @comment = Comment.find(params[:id]).destroy
    redirect_to user_video_path(@user, @video)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      @video = Video.friendly.find(params[:video_id])
      @comment = Comment.find(params[:id])
      if current_user.id != @comment.user_id
        redirect_to user_video_path(@user, @video)
        flash[:alert] = "This is not your comment."
      end
    end

    def subscriber
      @user = User.friendly.find(params[:user_id])
      @video = Video.friendly.find(params[:video_id])
      unless current_user.subscribed?(@user) || current_user == @user
        redirect_to user_video_path(@user, @video)
        flash[:alert] = "This is not your comment."
      end
    end

    def send_email
      return if user_signed_in? && @user.id == current_user.id
      userMailer.comment_email(@user, @comment).deliver_now unless @user.comment_email == false
    end

end
