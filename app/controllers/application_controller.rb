class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ApplicationControllerHelper

  before_action :authenticate_user!
end
