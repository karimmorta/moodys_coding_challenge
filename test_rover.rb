require "minitest/autorun"
require_relative './rover'
require_relative './plateau'

class RoverTest < Minitest::Test
    def setup
        upper_right_coordinates = "5 5"
        @plateau = Plateau.new(upper_right_coordinates)
        rover_current_position = "1 2 N"
        rover_2_current_position = "3 3 E"
        rover_3_current_position = "5 5 E"
        rover_4_current_position = "0 0 S"

        @rover = Rover.new(rover_current_position, @plateau)
        @rover_2 = Rover.new(rover_2_current_position, @plateau)
        @rover_3 = Rover.new(rover_3_current_position, @plateau)
        @rover_4 = Rover.new(rover_4_current_position, @plateau)
    end

    def test_ouput
        # Assert correct initialization of plateau
        assert_equal 5, @plateau.max_x
        assert_equal 5, @plateau.max_y

        # Assert correct initilization of the rover
        assert_equal "1 2 N", @rover.current_position_str
        assert_equal 1, @rover.current_x
        assert_equal 2, @rover.current_y
        assert_equal "N", @rover.direction

        
         # Moving the Rover #1
        instructions = "L M L M L M L M M"
        expected_position = "1 3 N"
        
        assert_equal expected_position, @rover.interpret_instructions(instructions)
        
        # Moving the Rover #2
        instructions_2 = "M M R M M R M R R M"
        expected_position_2 = "5 1 E"
        
        assert_equal expected_position_2, @rover_2.interpret_instructions(instructions_2)
        
        # Raise an error on incorrect instructions
        instructions_3 = "M M R M X Y M R R M" # X, Y are not accepted values
        
        assert_raises RuntimeError do
            @rover_2.interpret_instructions(instructions_3)
        end

        # Not going overboard, not moving
        instructions_3 = "M"
        expected_position_3 = "5 5 E"
        assert_equal expected_position_3, @rover_3.interpret_instructions(instructions_3)
        
        instructions_4 = "M"
        expected_position_4 = "0 0 S"
        assert_equal expected_position_4, @rover_4.interpret_instructions(instructions_4)
    end
end