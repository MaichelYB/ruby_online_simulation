class DetailHistory
    #replace getter and setter with one code
    attr_accessor :id, :id_hist, :menu, :quantity, :price, :total
    def initialize(id, id_hist, menu, quantity, price, total)
        @id = id
        @id_hist = id_hist
        @menu = menu
        @quantity = quantity
        @price  = price
        @total = total
    end
end