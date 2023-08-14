class Rover
    attr_reader :current_x, :current_y, :current_position_str, :direction 

    def initialize current_position, plateau
        @current_position_str = current_position
        @current_x, @current_y, @direction = @current_position_str.split
        @current_x = @current_x.to_i
        @current_y = @current_y.to_i
        @plateau = plateau
    end

    def interpret_instructions instructions
        instructions.split.each do |instruction|
            interpret_instruction instruction
        end
        @current_position_str
    end

    def interpret_instruction instruction
        # R or L (right or left) change cardinal direction
        # M (Move), change x or y position
        case instruction
        when "R"
            if @direction == "N"
                change_direction "E"
            elsif @direction == "W"
                change_direction "N"
            elsif @direction == "S"
                change_direction "W"
            elsif @direction == "E"
                change_direction "S"
            end
        when "L"
            if @direction == "N"
                change_direction "W"
            elsif @direction == "W"
                change_direction "S"
            elsif @direction == "S"
                change_direction "E"
            elsif @direction == "E"
                change_direction "N"
            end
        when "M"
            move
        else 
            raise "You've inputed an incorrect command! Use L, R, and M instructions."
        end
    end

    def change_direction new_direction
        @direction = new_direction
    end

    def move
        case @direction
        when "N"
            @current_y = @current_y + 1 unless @current_y == @plateau.max_y
        when "W"
            @current_x = @current_x - 1 unless @current_x == 0 
        when "S"
            @current_y = @current_y - 1 unless @current_y == 0
        when "E" 
            @current_x = @current_x + 1 unless @current_x == @plateau.max_x
        end
        @current_position_str = "#{@current_x} #{@current_y} #{@direction}"
    end
end