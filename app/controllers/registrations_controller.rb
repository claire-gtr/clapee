class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private
  def params
    params.require(:user).permit(:username, :password, :photo)
  end

end
