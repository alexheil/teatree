class Users::ProfilesController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @user = current_user
    @profile = @user.profile
    if @result = @profile.update_attributes(profile_params)
      redirect_to user_path(@user)
      flash[:notice] = "Updated."
    else
      render 'edit'
    end
  end

  private

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not your profile."
      end
    end

    def profile_params
      params.require(:profile).permit(:age, :biography, :display_name, :first_name, :last_name, :website, :city, :state, :country, :twitter_handle, :twitter_url, :youtube_handle, :youtube_url, :snapchat_handle, :snapchat_url, :image, :remove_image)
    end

end