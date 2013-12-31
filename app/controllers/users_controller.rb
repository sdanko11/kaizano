class UsersController < ApplicationController

  def index
  end

  def show
    @all_events = current_user.events
    @user = current_user
    binding.pry
  end

end