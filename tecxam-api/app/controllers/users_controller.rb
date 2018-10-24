class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
    json_response(@user)
  end
end
