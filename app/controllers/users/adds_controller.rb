class Users::AddsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @user = User.friendly.find(params[:user_id])
    @video = Video.friendly.find(params[:video_id])
    @playlist = Playlist.friendly.find(params[:add][:playlist_id])
    @add = Add.new
    @add.video_id = @video.id
    @add.playlist_id = @playlist.id
    if @add.save
      respond_to do |format|
       format.html { redirect_to user_video_path(@user, @video) }
       format.js { render :action => "adds" }
       flash.now[:notice] = "You have successfully added #{@video.title} to #{@playlist.title}!"
      end
    else
      redirect_to user_video_path(@user, @video)
      flash[:alert] = "You have failed."
    end
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    @playlist = Playlist.friendly.find(params[:playlist_id])
    @add = Add.find(params[:id])
    @video = @add.video
    @videos = @playlist.videos
    @playlist.unadd(@video)
    respond_to do |format|
      format.html { redirect_to user_playlist_path(@user, @playlist) }
      format.js { render :action => "adds" }
      flash.now[:notice] = "You removed #{@video.title} from #{@playlist.title}!"
    end
  end

end