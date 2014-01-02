class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @all_events = current_user.events
    @user = current_user
  end

end