require 'rails_helper'

describe '掲示板コメント投稿機能', type: :system do
  describe 'コメント表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'user_a')
      board = FactoryBot.create(:board, board_name: 'test_board', genre: 'マンガ', creator_name: 'user_A')
      comment = FactoryBot.create(:boardcomment, board_id: board.id , comment: 'おはよう', commentator: 'user_A')
    end

    context 'ユーザAでログインしているとき' do
      before do
        visit login_path
        fill_in 'name', with: 'user_a'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        click_link 'test_board'
      end

      it '投稿者がuser_aでコメントデータが表示されている' do
        expect(page).to have_content 'おはよう'
        expect(page).to have_content 'user_A'
      end

      it 'コメントを新規に投稿し、追加したコメントが表示される' do
        fill_in 'form_comment_comment', with: 'こんばんは'
        click_button 'コメント送信'

        expect(page).to have_content 'こんばんは'
      end
    end
  end

  describe 'コメント投稿機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'user_a')
      board = FactoryBot.create(:board, board_name: 'test_board', genre: 'マンガ', creator_name: 'user_A')
      comments = FactoryBot.build_list(:boardcomment, 1000, board_id: board.id, comment: 'おはよう', commentator: 'user_A')
      Boardcomment.import comments
    end
    context 'コメントが1000コメントある状態のとき' do
      before do
        visit login_path
        fill_in 'name', with: 'user_a'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        click_link 'test_board'
      end

      it '1000コメントある状態でコメントを送信したとき、alertメッセージが表示される' do
         fill_in 'form_comment_comment', with: 'こんばんは'
         click_button 'コメント送信'

         expect(page).to have_content 'コメントが1000コメントを超えました。新しい掲示板を作成してください。'
      end
    end
  end
end
