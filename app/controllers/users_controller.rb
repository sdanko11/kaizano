class UsersController < ApplicationController
  before_filter :validate_user, :only => :show

  # def index
  #   @all_events = current_user.events
  #   @user = current_user
  # end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:saved_changes]="Changes Saved"
      redirect_to users_path 
    else
      render action: 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @all_events = current_user.events
  end

  def validate_user
    redirect_to root_path unless current_user.id.to_s == params[:id]
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :twitter_handle,
    :linked_in_url, :phone_numer, :about_me)
  end


end