class Driver
    #replace getter and setter with one code
    attr_accessor :id, :name, :rating, :position
    def initialize(id, name, rating, position)
        @id = id
        @name = name
        @rating = rating
        @position = position
    end
end