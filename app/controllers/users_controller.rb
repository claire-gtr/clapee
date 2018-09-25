class UsersController < ApplicationController

  def me
    authorize current_user
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :photo)
  end

end
