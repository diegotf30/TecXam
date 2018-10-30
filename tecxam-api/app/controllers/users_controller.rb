class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    json_response(@user)
  end

  def index
    @users = User.all
    json_response(@users)
  end
end
