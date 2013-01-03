class Dungeon < ActiveRecord::Base
    attr_accessible :name, :numEnemies, :iorooms
    after_save :generate_rooms
    validates :name,  :presence => true
    validates :numEnemies, :presence => true
    
    has_many :rooms, :dependent => :destroy
    
    def listRooms()
		@rooms.each do |it|
			puts it.name
		end
	end
	
	def getRoom(index)
		room = self.rooms.find(index)
        return room
	end	
    
    private
    def generate_rooms

        @temprooms = JSON.parse(IO.read("vendor/assets/static/dungeon.txt"))
        rnum1 = rand(@temprooms.length - 3) + 2
        rnum2 = rand(@temprooms.length - 3) + 2
        if rnum1 == rnum2
            rnum2 = rnum2 + 1
        end
        
		@temprooms.each_with_index do |r, i|
            if i == rnum1
                room = self.rooms.create(:name => "Exit", :description => "This is the exit!",
            :entrance => "South", :exit =>"North"
            )
            elsif i == rnum2
                room = self.rooms.create(:name => "Minotaur", :description =>"This is the home of the Minotaur!",
            :entrance =>"South",:exit =>"North"
            )
            else
                room = self.rooms.create(:name => "Room_" + 
            r["row"].to_s + "-" + r["col"].to_s, :description =>r["description"],
            :entrance => r["entrance"]["dir"],:exit =>r["exit"]["dir"]
            )
            end
            room.save()
            self.rooms.push(room)
        end
    end
end