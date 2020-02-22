class SessionsController < ApplicationController
  skip_before_action :login_required

  def index
    @user = User.new
  end

  def login
    member = User.find_by(name: params[:name])
    if member&.authenticate(params[:password])
      session[:member_id] = member.id
      session[:name] = params[:name]

      redirect_to board_index_path, notice:"ログインしました。"
    else
      flash.alert = "名前とパスワードが一致しません。"
      render 'sessions/index'
    end
  end

  def destroy
    session.delete(:member_id)
    session.delete(:name)
    redirect_to :root
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to login_index_url, notice: "ユーザを登録しました。"
    else
      render 'sessions/new'
    end
  end

end
