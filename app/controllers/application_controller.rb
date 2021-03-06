class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  before_action :require_login

  rescue_from 'CanCan::AccessDenied' do |exception|
    flash[:notice] = t 'notice.unauthorized_action'
    redirect_to contents_url
  end
end
