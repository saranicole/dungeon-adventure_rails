class RoomsController < ApplicationController
  def create
    @dungeon = Dungeon.find(params[:dungeon_id])
    @room = @dungeon.rooms.create(params[:room])
    redirect_to dungeon_path(@dungeon)
  end
  def destroy
    @dungeon = Dungeon.find(params[:dungeon_id])
    @room = @dungeon.rooms.find(params[:room])
    @room.destroy
    redirect_to dungeon_path(@dungeon)
  end
end
