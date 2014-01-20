class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_user, :only => :show

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:saved]="Saved Changes"
      redirect_to  user_path
    else
      render action: 'edit'
    end
  end

  def show

    @user = User.find(params[:id])
    @all_events = current_user.events
  end

  def validate_user
    if !current_user.nil?
      redirect_to root_path unless current_user.id.to_s == params[:id]
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :twitter_handle,
    :linked_in_url, :phone_numer, :about_me, :avatar)
  end
  
end