class Game < ActiveRecord::Base
  attr_accessor :player
  attr_accessible :player, :player_id, :dungeon, :dungeon_id, :roomindex, :over
  after_save :roomindexSet

  belongs_to :dungeon

  validates :dungeon, :presence => true
  
  has_many :moves, :dependent => :destroy
  
  private
  def roomindexSet
    if self.roomindex == nil && self.over == nil
        room = self.dungeon.rooms.first(:order => 'created_at DESC')
        self.roomindex = room.id
        self.over = false
    end
  end
  
end



