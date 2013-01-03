class Player < ActiveRecord::Base
  attr_accessor :location
  attr_accessible :name, :race, :stats, :health, :items, :dungeon, :location
  before_save :initializePlayer
  serialize :items, Array
  belongs_to :game
  
    def meet(direction, actor)
		outcome = "You've met a " + actor[:race] + "!\n"
        outcome += self.attack(direction, actor)

        return outcome
	end
	
	def set_name(name)
		@name = name
	end
	
	def enter(room)
		self.location = room
        self.save()
        outcome = {:name => "", :level => 0}
        if room.name == "Exit"
            outcome[:name] += "You win! You were level " + self.stats.to_s + "."
            outcome[:level] = 1111
        elsif room.name == "Minotaur" && self.stats < 100
            outcome[:name] += "You lose! You were health " + self.health.to_s + "."
            outcome[:level] = 2222
        elsif room.name == "Minotaur" && self.stats >= 100
            outcome[:name] += "You beat the Minotaur! You were level " + self.stats.to_s + "."
            outcome[:level] = 1111
        end
        return outcome
	end
	
	def move(move)
        self.location = move.room
		encounter = move.room.encounter(self, move)
		outcome = ""
	#	if encounter.class.to_s == "Fixnum"
	#		return encounter
	#	end
		if encounter != nil
			if encounter.has_key?(:race)
				outcome += self.meet(move.direction, encounter)
			elsif encounter[:level] < 9999	
				outcome += encounter[:name] + ", Level " + encounter[:level].to_s
				outcome += ".  You have taken the object " + encounter[:name] + "."
				self.take(encounter)
                move.room.surrender(move.direction)
            elsif encounter[:level] == 9999 
                outcome += encounter[:name]
                move.room = self.location
			end
		else outcome += "Nothing here."
		end
		return outcome
	end
	
	def take(stuff)
        if self.items == nil
            self.items = []
        end

        self.items.push(stuff)
        self.stats = self.items.sum do |i| 
            i[:level]
        end
        self.save()
        return stats
	end		
    
    def attack(direction, actor)
		self.items.sum do |i| i[:level]
        end
		actor_stats = actor[:items].sum do |i| i[:level] end
		outcome = "You are level " + self.stats.to_s
		outcome += ", They are level " + actor_stats.to_s

		other = (actor_stats / 5).floor
		if self.stats > actor_stats
			outcome += self.win(actor_stats)
			self.loot(actor[:items])
			self.location.surrender(direction)
		elsif actor_stats >= self.stats
            outcome +=  " " + actor[:race] + " wins! "
			outcome += self.lose(actor_stats - self.stats)
			
		end
        return outcome
	end

		
	def win(stats)
		self.stats += stats
        self.save()
		return  " " + self.name + " wins!"
	end
	
	def lose(health)
		self.health -= health
		outcome = " " + self.name + " has remaining Health: " + self.health.to_s + "!"
		if self.health <= 0
			outcome += self.name + " is dead!"
		end
        self.save()
		return outcome
	end
	
	def loot(stuff)
        stuff.each do |s|
            self.items.push(s)
        end
        self.stats = self.items.sum do |i| 
            i[:level]
        end
        self.save()
	end
	
	def drop(item)
		if @items.include?(item)
			if (item.length > 1)
			split(@items, @items.index(item[0]), @items.index(item[item.length - 1]) + 1)
			else
			split(@items, @items.index(item), @items.index(item) + 1)
			end
		end
	end
	
	def heal()
		potion = @items.find{|it| it.name == "Healing"}
        outcome = ""
		if defined?(potion) && potion != nil
			@health += potion.level
			outcome += @name + " healed " + potion.level.to_s + " points. Health is now " + @health.to_s + "."
		else outcome += @name + " is out of Healing potions."
		end
        return outcome
	end

    def split( arr,  firstindex,  secondindex)
        arr.inject([]) do |target, it|
            if !(firstindex <= arr.index(it) && arr.index(it) < secondindex)
                target << it
            end
            target
        end
    end
    
  private
  def initializePlayer()
    if self.stats == nil && self.health == nil && self.items == nil
        self.stats = 0
        self.health = 100
        self.items = []
    end
  end
  
end

