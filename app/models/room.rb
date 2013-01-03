class Room < ActiveRecord::Base
  attr_accessible :name, :description, :contents, :index, :entrance, :exit
  before_save :generate_contents
  serialize :contents, Hash

  belongs_to :dungeon
  
  def list_contents()
        @contents.each do |key, val|
            puts key.to_s + " " + val[:name] + " " + val[:level].to_s
        end
    end
    
    def surrender(direction)
        contents = self.contents.to_hash
        contents.store(direction.to_sym, nil)
        self.contents = contents
        self.save()
    end
        
    def encounter(caller, move)
        outcome = {:name => "", :level => 0}
        if self.exit == move.direction
            outcome[:name] += "You found a door to the " + move.direction.to_s + "!"
            outcome[:level] = 9999
            move.game.roomindex = move.game.roomindex + 1
            move.game.save()
            caller.enter(self.dungeon.getRoom(move.game.roomindex))
            return outcome
        end
        
        if self.contents == nil
            self.contents = {}

        end
        
        if self.contents.has_key?(move.direction.to_sym)
            contents = self.contents.fetch(move.direction.to_sym)

        return contents
        else outcome[:name] += "Room does not contain " + move.direction
        end
        return outcome
    end

  def generate_contents()
    if (self.contents == nil || self.contents == {})
        self.contents = {}
        tempitems = []
        directions = [:North, :South, :West, :East]
        directions.each_with_index do |dir, i|
            if dir != @exit
                gold = {:name=>"Gold", :level => 1 + rand(9)}
                weapon = {:name=>["Sword", "Dagger", "Bow"][rand(2)], :level => 1 + rand(9)}
                armor= {:name=>["Gauntlets","Helmet","Boots"][rand(2)], :level => 1 + rand(9)}
                potion = {:name=>["Healing","Poison","Invisibility"][rand(2)], :level => 1 + rand(9)}
                tempitems.push(gold)
                tempitems.push(weapon)
                tempitems.push(armor)
                tempitems.push(potion)
                item = tempitems[rand(4)]
                self.contents.store(dir, item)

            end
        end
    end
  end
  
end

class Item
        attr_accessor :name, :room
        
        def whoami()
            puts @name
            return @name
        end
        
        def whereami()
            puts @room
            return @room
        end

    end

    class Levelable < Item
        attr_accessor :level, :cost
        
        def set_upgrade_cost(cost)
            @cost = cost
        end
        
        def upgrade(money)
            newlevel = (@cost / money).floor
            level += newlevel
            self.upgrade_level
        end
        
        
    end

    class Gold < Levelable

    end

    class Weapon < Levelable

        
    end

    class Armor < Levelable
        
    end

    class Potion < Levelable
        
    end
  