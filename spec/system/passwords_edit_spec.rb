require 'rails_helper'

describe 'パスワード変更機能', type: :system do
  describe 'パスワード変更機能' do
    before do
      # ユーザAを作成しておく
      user_a = FactoryBot.create(:user, name: 'user_a')
      # 掲示板情報を作成しておく
      board = FactoryBot.create(:board, board_name: '最初の掲示板', creator_name: 'user_a')
      # ログインしておく
      visit login_path
      fill_in 'name', with: 'user_a'
      fill_in 'password', with: 'password'
      click_button 'ログイン'
      # パスワード変更画面に遷移する
      click_link 'パスワード変更'
    end
    
    context 'ユーザAのパスワードを変えるとき' do
      it 'パスワードが変更できる' do
        # 必要な情報を入力する
        fill_in 'user_current_password', with: 'password'
        fill_in 'user_password', with: 'password1'
        fill_in 'user_password_confirmation', with: 'password1'
        #　パスワードを変更する
        click_button 'パスワード変更'

        expect(page).to have_content 'パスワードを変更しました。'
      end
    end

    context 'ユーザAのパスワード変えた後にログインする。' do
      before do
        fill_in 'user_current_password', with: 'password'
        fill_in 'user_password', with: 'password1'
        fill_in 'user_password_confirmation', with: 'password1'
        click_button 'パスワード変更'
        visit login_path
      end
      
      it '変更後のパスワードでログインできること' do
        fill_in 'name', with: 'user_a'
        fill_in 'password', with: 'password1'
        click_button 'ログイン'

        expect(page).to have_content 'ログインしました。'
      end
    end 
  end
end
