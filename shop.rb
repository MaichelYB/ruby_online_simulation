class Shop
    #attr reader, we can use it to replace get method
    attr_reader :id, :name, :position

    #attr_writer, we can use it to replace set method
    attr_writer :id, :name, :position
    
    def initialize(id, name, position)
        @id = id
        @name = name
        @position = position
    end
end