class Food
    #attr reader, we can use it to replace get method
    attr_reader :shop_id, :id, :name, :price

    #attr_writer, we can use it to replace set method
    attr_writer :shop_id, :id, :name, :price
    
    def initialize(shop_id, id, name, price)
        @shop_id = shop_id
        @id = id
        @name = name
        @price = price
    end
end