class Users::FollowsController < ApplicationController
  
  def create
    user = User.find(params[:followed_id])
    @user = User.friendly.find(user)
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to user_path(user) }
      format.js { render :action => "follows" }
      flash.now[:notice] = "You have followed #{user.profile.display_name.presence || user.username}!"
    end
  end

  def destroy
    user = Follow.find(params[:id]).followed
    @user = User.friendly.find(user)
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to user_path(user) }
      format.js { render :action => "follows" }
      flash.now[:notice] = "You have unfollowed #{user.profile.display_name.presence || user.username}!"
    end
  end
  
end