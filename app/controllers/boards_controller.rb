class BoardsController < ApplicationController
  def index
    @boards = Board.all
    @board = Board.new
  end

  def create
    @board = Board.new(params[:board])
    @board.creator_name = session[:name]

    if @board.save 
      redirect_to board_index_url, notice: "掲示板を作成しました。"
    else
      render "board"
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    redirect_to board_index_url, notice: "掲示板を削除しました。"
  end
end
