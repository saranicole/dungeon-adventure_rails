class Move < ActiveRecord::Base
  attr_accessible :outcome, :direction, :game
  belongs_to :room
  belongs_to :game
  before_save :populateEnemies
  before_save :moveOutcome

  validates :game, :presence => true
  
  def moveOutcome()
    player = Player.find(self.game.player_id)
    dungeon = self.game.dungeon
    if self.game.roomindex == nil        
        room = self.game.dungeon.rooms.first(:order => 'created_at DESC')
        self.game.roomindex = room.id
        self.game.save()
    end
    
    result = player.enter(dungeon.getRoom(self.game.roomindex))
    
    if result[:level] >= 1111
        self.outcome = result[:name]
        self.game.over = true
        self.game.save()

        return
    end
    
    obj = player.move(self)
    if obj.class.to_s == "Fixnum"
        if obj > 1
            return
        end
    else
        self.outcome = obj
        player.enter(dungeon.getRoom(self.game.roomindex))
        self.game.roomindex = self.game.roomindex + 1
        self.outcome += "  Which way would you like to move?"

    end
  end
  
   private
   def populateEnemies()
         if self.game.roomindex == nil        
            room = self.game.dungeon.rooms.first(:order => 'created_at ASC')
            self.game.roomindex = room.id
            self.game.save()
        end
        self.room = self.game.dungeon.getRoom(self.game.roomindex)

        if self.game.dungeon.numEnemies > 0
            self.outcome = ""
            rnum = rand(4)
            directions = [:North, :South, :West, :East]
            if rnum > 2
                e = {:race => ["Dragon", "Goblin","Bandit"][rand(2)], :dungeon => self.game.dungeon,
                :location => room}
                gold = {:name=>"Gold", :level => rand(10)}
                weapon = {:name=>["Sword", "Dagger", "Bow"][rand(2)], :level => 1 + rand(9)}

                armor= {:name=>["Gauntlets","Helmet","Boots"][rand(2)], :level => 1 + rand(9)}

                potion = {:name=>["Healing","Poison","Invisibility"][rand(2)], :level => 1 + rand(9)}

                e[:items] = [gold, weapon, armor, potion]
                self.room.contents.store(directions[rand(4)], e)
            end
            self.game.dungeon.numEnemies = self.game.dungeon.numEnemies - 1
        end
	end  
	 
end