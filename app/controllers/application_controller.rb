class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_default_format

  private

  def set_default_format
    request.format = :json  # This sets the default response format to JSON
  end
end
