class Auth::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      render json: resource, status: :ok
    else
      validation_error(resource)
    end
  end
end