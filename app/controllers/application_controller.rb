class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  before_action :require_login

  rescue_from 'CanCan::AccessDenied' do |exception|
    redirect_to contents_url
  end
end
