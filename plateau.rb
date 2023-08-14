class Plateau
    attr_reader :max_x, :max_y
    def initialize upper_right_coordinates
        @upper_right_coordinates = upper_right_coordinates
        @max_x = @upper_right_coordinates.split[0].to_i
        @max_y = @upper_right_coordinates.split[1].to_i
    end
end