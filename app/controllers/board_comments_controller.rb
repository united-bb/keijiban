class BoardCommentsController < ApplicationController
  
  def index
    query = "SELECT row_id, id, comment, created_at FROM boardcomments WHERE board_id=? ORDER created_at;"
    @board = Board.find(params[:id])
    @comments = Boardcomment.where(board_id: params[:id]).order(created_at: :asc)
    @comment = Boardcomment.new
  end

  def create
    @comment = Boardcomment.new(params[:form_comment])
    @comment.board_id = params[:id]
    @comment.commentator = session[:name]

    @comments_count = Boardcomment.where(board_id: params[:id] ).count
    

    # 登録済みコメントが1000コメント以上の場合
    begin
      if @comments_count >= 1000
        raise "コメントが1000コメントを超えました"
      end
    rescue  Exception
      flash.alert = "コメントが1000コメントを超えました。新しい掲示板を作成してください。
      "
      redirect_to board_comment_url
      return
    end
    
    # 登録済みコメントが1000コメント未満の場合
    if @comment.save
      redirect_to board_comment_url, notice: "コメントを送信しました。"
      return
    else
      render "board_comment"
      return
    end
  end
end
