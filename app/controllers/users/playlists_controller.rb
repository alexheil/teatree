class Users::PlaylistsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :search]
  before_action :correct_user, only: [:new, :create]
  before_action :correct_playlist_user, only: [:edit, :update, :destroy]
  before_action :set_user, except: [:show, :search]

  def index
    @user = User.friendly.find(params[:user_id])
    if user_signed_in? && @user == current_user
      @playlists = @user.playlists
    else
      @playlists = @user.playlists #public only
    end
  end

  def show
    @user = User.friendly.find(params[:user_id])
    @playlist = Playlist.friendly.find(params[:id])
    @videos = @playlist.videos
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = @user.playlists.build(playlist_params)
    if @playlist.save
      flash[:notice] = "You just created " + @playlist.title + "!"
      redirect_to user_playlist_path(@user, @playlist)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @playlist = Playlist.friendly.find(params[:id])
  end

  def update
    @playlist = Playlist.friendly.find(params[:id])
    if @playlist.update_attributes(playlist_params)
      flash[:notice] = "You just updated " + @playlist.title + "!"
      redirect_to user_playlist_path(@user, @playlist)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      redirect_to root_url
    end
  end

  def destroy
    @playlist = Playlist.friendly.find(params[:id]).destroy
    redirect_to user_path(@user)
  end

  private

    def playlist_params
      params.require(:playlist).permit(:title, :description, :image, :remove_image, :policy_type)
    end

    def set_user
      @user = current_user
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not your profile."
      end
    end

    def correct_playlist_user
      @playlist = Playlist.friendly.find(params[:id])
      redirect_to user_path(@playlist.user_id) if @playlist.user_id != current_user.id
    end

end