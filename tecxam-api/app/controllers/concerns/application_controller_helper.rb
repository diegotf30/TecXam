module ApplicationControllerHelper
  def block_unless_owner(resource)
    unless current_user == resource.user
      render json: nil, status: :unauthorized
    end
  end
end