class SessionsController < ApplicationController

  def create
    member = User.find_by(name: params[:name])
    if member&.authenticate(params[:password])
      session[:member_id] = member.id
      session[:name] = params[:name]
    else
      flash.alert = "名前とパスワードが一致しません。"
    end
    redirect_to board_index_path, notice: "ログインしました。"
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end

end
