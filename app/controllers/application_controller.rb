class ApplicationController < ActionController::Base
  before_action :authenticate_psychologist!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def record_not_found
    redirect_to root_path
  end
end
