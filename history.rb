class History
    #replace getter and setter with one code
    attr_accessor :id, :id_user, :date, :price
    def initialize(id, id_user, date, price)
        @id = id
        @id_user = id_user
        @date = date
        @price  = price
    end
end