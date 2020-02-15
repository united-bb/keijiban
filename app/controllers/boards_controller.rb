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

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @board.board_name = params[:board_form][:board_name]

    if @board.save
      redirect_to board_show_url, notice: "掲示板名を更新しました。"
    else
      render 'board/:id/edit'
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    redirect_to board_index_url, notice: "掲示板を削除しました。"
  end
end
