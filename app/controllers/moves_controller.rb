class MovesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @move = @game.moves.create(params[:move])
    redirect_to game_path(@game)
  end
  def destroy
    @game = Game.find(params[:game_id])
    @move = @game.moves.find(params[:move])
    @move.destroy
    redirect_to game_path(@game)
  end
end