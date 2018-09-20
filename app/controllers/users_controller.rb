class UsersController < ApplicationController

  def me
    authorize current_user
  end

end
