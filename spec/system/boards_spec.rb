require 'rails_helper'

describe '掲示板作成機能', type: :system do

  describe '一覧機能' do
    before do
      # ユーザを作成しておく
      user_a = FactoryBot.create(:user, name: 'user_A')
      user_b = FactoryBot.create(:user, name: 'user_B')
      # 作成者が「テストユーザ」である掲示板を作成しておく
      board = FactoryBot.create(:board, board_name: '最初の掲示板', creator_name: 'user_A')
    end

    context '「user_A」がログインしているとき' do
      before do
        # 「user_A」でログインする
        visit login_path
        fill_in 'name', with: 'user_A'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
      end

      it '「最初の掲示板」が表示される' do
        # 作成済みの掲示板名称が画面上に表示されていることを確認
        expect(page).to have_content '最初の掲示板'
      end

      it '「編集リンクが表示される」' do
        expect(page).to have_content '詳細'
      end

      it '「削除リンクが表示される」' do
        expect(page).to have_content '削除'
      end
    end

    context 'user_Bがログインしているとき' do
      before do
        visit login_path
        fill_in 'name', with: 'user_B'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
      end

      it '「最初の掲示板」が表示されている' do
        expect(page).to have_content '最初の掲示板'
      end
      
      it '詳細リンクが表示されていない' do
        expect(page).to have_no_content '詳細'
      end

      it '削除リンクが表示されていない' do
        expect(page).to have_no_content '削除'
      end

      it '「test_board」を新規作成し、その後の画面で表示されていること' do
        fill_in 'board_board_name', with: 'test_board'
        click_button '掲示板新規作成'

        expect(page).to have_content 'test_board'
      end
    end
  end
end 
