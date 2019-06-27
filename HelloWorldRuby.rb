puts 'Hello World Ruby!!'

def say_hi(name)
    puts "Hello #{name}"
end

a = 5
b = 1
puts "sum of a + b = #{a+b}"

say_hi("maichel")

$many_history = History.new(id, $many_shop.select{|food| food.id  == "#{shop_id}"}.map{|name|name.instance_variable_get(:@name)}[0],
                    $many_food.select{|shop_id|shop_id.shop_id == "#{shop_id}" and shop_id.id == "#{i}"}.map{|name|name.instance_variable_get(:@name)}[0],
                    $many_food.select{|shop_id|shop_id.shop_id == "#{shop_id}"}.select{|food_id|food_id.id == "#{i}"}.map{|name|name.instance_variable_get(:@price)}[0])
                    puts "Do you want to order more items??(Y/N)"
                    more = gets.chomp

                    while more=="Y"

                    end