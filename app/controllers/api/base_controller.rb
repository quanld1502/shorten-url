class Api::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  include JwtSupport

  private

  def request_authorize
    @current_user ||= current_access_token&.user
  end
end