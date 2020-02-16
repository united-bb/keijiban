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

     if @comment.save
        redirect_to board_comment_url, notice: "コメントを送信しました。"
     else
       render "board_comment"
     end
  end
end
