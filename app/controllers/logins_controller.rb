class LoginsController < ApplicationController
  def index
    @user = User.new
  end

  def new
    @user = User.new  
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to login_url, notice: "ユーザを登録しました。"
    else
      render 'login'
    end
  end
end
