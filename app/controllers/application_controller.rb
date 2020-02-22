class ApplicationController < ActionController::Base
  before_action :login_required

  private def current_member
    User.find_by(id: session[:member_id]) if session[:member_id]
  end

  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  private def login_required
    begin
      raise LoginRequired unless current_member
    rescue
      flash.alert = "ログインしてください。"
      redirect_to :root
      return
    end
  end
end
