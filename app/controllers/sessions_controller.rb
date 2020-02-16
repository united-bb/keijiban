class SessionsController < ApplicationController

  def create
    member = User.find_by(name: params[:name])
    if member&.authenticate(params[:password])
      session[:member_id] = member.id
      session[:name] = params[:name]

      redirect_to board_index_path, notice:"ログインしました。"
    else
      flash.alert = "名前とパスワードが一致しません。"
      render 'logins/index'
    end
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end

end
