class Users::SavesController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:video_id])
    @save = Save.new
    @save.user_id = current_user.id
    @save.video_id = @video.id
    if @save.save
      respond_to do |format|
        format.html { redirect_to user_video_path(@video.user, @video) }
        format.js { render :action => "saves" }
        flash.now[:notice] = "You have successfully saved #{@video.title}!"
      end
    else
      redirect_to user_video_path(@user, @video)
      flash[:alert] = "You have failed."
    end
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:video_id])
    current_user.unsave(@video)
    respond_to do |format|
      format.html { redirect_to user_video_path(@video.user, @video) }
      format.js { render :action => "saves" }
      flash.now[:notice] = "You unsaved #{@video.title}!"
    end
  end

end