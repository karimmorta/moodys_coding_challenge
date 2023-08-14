require_relative './rover'
require_relative './plateau'

class RoverSquadControlInterface
    def initialize(instructions=nil, number_of_rovers=nil)
        @instructions = instructions
        @number_of_rovers = number_of_rovers
        @upper_right_coordinates_plateau = nil
    end

    def interface
        # Use of multiple gets to gather input
        print "How many rovers ?\n"
        number_of_rovers = gets
        puts "=> #{number_of_rovers.chomp!} rovers in total"
        print "What are the upper right coordinates of the plateau ? Exemple : 5 5\n"
        upper_right_coordinates_plateau = gets
        puts "=> #{upper_right_coordinates_plateau.chomp!} are the upper right coordinates of the plateau"
        number_of_rovers.to_i.times do |time|
            time = time + 1
            print "What is rover #{time}'s current position ? Exemple : 1 2 N\n"
            rover_current_position = gets
            puts "=> #{rover_current_position.chomp!} are the coordinates of the rover #{time}"
            plateau = Plateau.new(upper_right_coordinates_plateau)
            rover = Rover.new(rover_current_position, plateau)
            puts rover.current_position_str
            begin
                print "What are the instructions for the rover #{time}? Exemple : L M L M L M L M M\n"
                rover_instructions = gets
                rover.interpret_instructions(rover_instructions)
            rescue RuntimeError
                puts "Please only use R, L and R values"
                retry
            end
            puts "=> OK, #{rover_instructions.chomp!} are the instructions for the rover #{time}"
            puts "=> Moving..."
            puts "=> Rover #{time} moved ! Current position : #{rover.current_position_str}"
        end
    end
end

RoverSquadControlInterface.new.interface