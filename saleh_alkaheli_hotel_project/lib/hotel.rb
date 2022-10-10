require_relative "room"

class Hotel

    attr_reader :rooms
    def initialize(name, hash)
        @name = name
        @rooms = Hash.new(0)
        hash.each{ |k, v| @rooms[k] = Room.new(v)}

    end

    def name
        @name.split(' ').map{|ele| ele.capitalize}.join(' ')
    end

    def room_exists?(str)
        @rooms.keys.include?(str)
    end

    def check_in(person, room)
        if !room_exists?(room)
            print 'sorry, room does not exist'
        else
            if  @rooms[room].add_occupant(person) == true
                print 'check in successful'
            else
                print 'sorry, room is full'
            end
        end
    end

    def has_vacancy?
        @rooms.each do |k, v|
            if v.available_space >= 1
                return true
                break
            else
                return false
            end
        end
    end

    def list_rooms
        @rooms.each do |k, v|
            print k
            print v.available_space
            puts
        end
    end

end
