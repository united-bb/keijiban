require 'rails_helper'

describe '新規ユーザ登録機能', type: :system do
  describe '新規ユーザ登録' do
    before do
      # 掲示板データを作っておく
      board = FactoryBot.create(:board, board_name: 'テスト掲示板', creator_name: 'user_a')
    end

    context 'ユーザCを作成する。' do
      before do
        visit login_path
        click_link '新規ユーザ登録'
      end

      it 'ユーザCを登録する' do
        fill_in 'user_name', with: 'user_c'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'ユーザ登録'

        expect(page).to have_content 'ユーザを登録しました。'
      end
    end

    context 'ユーザDを作成してログインする。' do
      before do
        visit login_path
        click_link '新規ユーザ登録'
        fill_in 'user_name', with: 'user_d'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'ユーザ登録'
      end

      it 'ユーザCでログインする' do
        visit login_path
        fill_in 'name', with: 'user_d'
        fill_in 'password', with: 'password'
        click_button 'ログイン'

        expect(page).to have_content 'ログインしました。'
      end
    end
  end
end
