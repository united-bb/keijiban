class LoginsController < ApplicationController

  def edit
    @user = User.find(session[:member_id])
  end

  def update
    @user = User.find(session[:member_id])
    current_password = params[:user][:current_password]
    
    if current_password.present?
      if @user.authenticate(current_password)
        @user.assign_attributes(params[:user])
        if @user.save
          redirect_to board_index_url, notice: "パスワードを変更しました。"
        else
          render 'logins/edit'
        end
      else
        render 'logins/edit'
      end
    else
      render 'logins/edit'
    end
  end

end
