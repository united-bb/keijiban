require 'rails_helper'

describe 'ログイン機能', type: :system do
  describe 'ログイン' do
    before do
      # ユーザAのデータを作成する
      user_a = FactoryBot.create(:user, name: 'user_a')
      # 掲示板データを用意する。
      board = FactoryBot.create(:board, board_name: 'テスト掲示板', creator_name: 'user_a')
      visit login_path
    end

    context 'ユーザーAでログインするとき' do
      
      it 'user_aでログインする' do
        fill_in 'name', with: 'user_a'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end

    context '存在しないユーザでログインするとき' do

      it 'user_bでログインする' do
        fill_in 'name', with: 'user_b'
        fill_in 'password', with: 'password'
        click_button 'ログイン'

        expect(page).to have_content '名前とパスワードが一致しません。'
      end
    end

    context '存在するユーザでSQLインジェクション対策確認' do
      
      it 'ユーザAでパスワードSQLインジェクション文字列にする' do
        fill_in 'name', with: 'user_a'
        fill_in 'password', with: "1' or '1' = '1';-- "
        click_button 'ログイン'

        expect(page).to have_content '名前とパスワードが一致しません。'
      end
    end
  end
end
