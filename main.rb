require_relative 'food'
require_relative 'driver'
require_relative 'shop'
require_relative 'user'
require_relative 'detailHistory'
require_relative 'history'
require 'date'

#initialize variable
$many_food = Array.new([])
$many_driver = Array.new([])
$many_shop = Array.new([])
$many_user = Array.new([])
$many_history = Array.new([])
$history = Array.new([])

$id = 0

#random to get position
pos = (0..24).to_a.shuffle

#add data to array
$many_food << Food.new("0", "0", 'Sausage', 1000)
$many_food << Food.new("0", "1", 'Soup', 2000)

$many_food << Food.new("1", "0", 'Noodle', 1000)
$many_food << Food.new("1", "1", 'Spagethi', 2000)

$many_food << Food.new("2", "0", 'Pasta', 3000)
$many_food << Food.new("2", "1", 'Cake', 4000)

$many_driver << Driver.new("0", 'Maichel', 0.0, pos[0])
$many_driver << Driver.new("1", 'Adi', 0.0, pos[1])
$many_driver << Driver.new("2", 'Suratman', 0.0, pos[2])
$many_driver << Driver.new("3", 'Taro', 0.0, pos[3])
$many_driver << Driver.new("4", 'Cecep', 0.0, pos[4])

$many_shop << Shop.new("0", "Western Restaurant", pos[5])
$many_shop << Shop.new("1", "Noodle Restaurant", pos[6])
$many_shop << Shop.new("2", "Cake and Pasta Restaurant", pos[7])

$many_user << User.new("0", "Yunarto", pos[8])

$maps  = Array.new(5){Array.new(5," Road[] ")}

#initialize boolean for appearing the driver or shop
isShopAppear = true
isDriverAppear = true

total_shop = 0
total_driver = 0
maps_position_all = 0

#get user position
pos_user = $many_user.select{|user| user.id == "0"}.map{|pos_user| pos_user.instance_variable_get(:@position)}

for i in 0..4
    for j in 0..4
        #get driver and shop position
        pos_driver = $many_driver.select{|driver| driver.id == "#{total_driver}"}.map{|pos_driver|Integer(pos_driver.instance_variable_get(:@position))}
        pos_shop = $many_shop.select{|shop| shop.id == "#{total_shop}"}.map{|pos_shop|Integer(pos_shop.instance_variable_get(:@position))}
    
        for dr in 0..4
            p_dr = $many_driver.select{|driver| driver.id == "#{dr}"}.map{|pos_driver|Integer(pos_driver.instance_variable_get(:@position))}
            if maps_position_all == p_dr[0]
                $maps[i][j] = " D#{$many_driver.select{|driver| driver.id  == "#{dr}"}.map{|name|name.instance_variable_get(:@name)[0]}} "
                # maps_position_all+=1
                break
            end
        end
        for sh in 0..2
            p_sh = $many_shop.select{|shop| shop.id == "#{sh}"}.map{|pos_shop|Integer(pos_shop.instance_variable_get(:@position))}
            if maps_position_all == p_sh[0]
                $maps[i][j] = " S#{$many_shop.select{|food| food.id  == "#{sh}"}.map{|name|name.instance_variable_get(:@name)[0]}} "
                # maps_position_all+=1
                break
            end
        end
        if pos_user[0] == maps_position_all
            $maps[i][j] = " USER[] "
        end
        maps_position_all+=1
    end
end

def printMap()
#print the map
    for i in 0..4
        for j in 0..4
            print $maps[i][j]
        end
        print "\n"
    end
end

def chooseStore()
    puts "Please choose the shop! (type just id, eg: 1 is for Western Restaurant etc, x for exit)"
    for i in 0..2
        puts "#{i} #{$many_shop.select{|food| food.id  == "#{i}"}.map{|name|name.instance_variable_get(:@name)}}"
    end

    #input shop id
    $shop_id = gets.chomp
    count_shop = $many_food.select{|shop| shop.shop_id == "#{$shop_id}"}.count

    puts count_shop
    if $shop_id=="x" or $shop_id=="X" or $shop_id.to_i>count_shop
        puts "Pesanan batal"
    else
        puts "Please choose food from menu (type just the food id), x to cancel"
        $detil = 0
            for i in 0..$many_food.select{|shop_id| shop_id.shop_id == "#{$shop_id}"}.count-1
                $food_name = $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{i}"}.map{|name|name.instance_variable_get(:@name)}[0]
                $food_price = $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}"}.select{|food_id|food_id.id == "#{i}"}.map{|name|name.instance_variable_get(:@price)}[0]
                print i, ". menu: ", $food_name," price: ",$food_price
                print "\n"
            end

            $food_id = gets.chomp
            puts $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@name)}[0]
            if $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}"}.map{|name|name.instance_variable_get(:@id)}.count>$food_id.to_i
                puts "Please insert the quantity! (insert>0)"
                $quantity = gets.chomp

                if $quantity.to_i == 0 or $quantity.to_i == nil
                    puts "You cannot order 0 quantity"
                else
                    $detil = 0
                    $many_history << DetailHistory.new($detil, $id, 
                        $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@name)}[0],
                        $quantity, $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@price)}[0],
                        $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@price)}[0].to_i * $quantity.to_i)
                    $detil+=1
                    puts "Do you want to order more items??(Y/N)"
                    $more = gets.chomp
                end

                    while $more=="Y"
                        for i in 0..$many_food.select{|shop_id| shop_id.shop_id == "#{$shop_id}"}.count-1
                            $food_name = $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{i}"}.map{|name|name.instance_variable_get(:@name)}
                            $food_price = $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}"}.select{|food_id|food_id.id == "#{i}"}.map{|name|name.instance_variable_get(:@price)}
                            print i,$food_name," price: ",$food_price
                            print "\n"
                        end
                        $food_id = gets.chomp

                puts $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@name)}[0]
                if $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}"}.map{|name|name.instance_variable_get(:@id)}.count>$food_id.to_i
                    puts "Please insert the quantity! (insert>0)"
                    $quantity = gets.chomp

                    if $quantity.to_i == 0 or $quantity.to_i == nil
                        puts "You cannot order 0 quantity"
                    else
                        $detil = 0
                        $many_history << DetailHistory.new($detil, $id, 
                            $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@name)}[0],
                            $quantity, $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@price)}[0],
                            $many_food.select{|shop_id|shop_id.shop_id == "#{$shop_id}" and shop_id.id == "#{$food_id}"}.map{|name|name.instance_variable_get(:@price)}[0].to_i * $quantity.to_i)
                        $detil+=1
                        puts "Do you want to order more items??(Y/N)"
                        $more = gets.chomp
                    end
                end
            end
            if $more=="N"
                # puts $many_history.select{|trans_id| trans_id.id_hist == $id}.map{|name|name.instance_variable_get(:@id)}.count-1
                $price_tot = 0
                puts $id
                p $many_history
                # puts $many_history.select{|trans_id| trans_id.id == i and trans_id.id_hist == $id}.map{|price|Integer(price.instance_variable_get(:@total))}[0]
                for i in 0..$many_history.select{|trans_id| trans_id.id_hist == $id}.map{|name|name.instance_variable_get(:@id)}.count-1
                    $price_tot+=$many_history.select{|trans_id| trans_id.id_hist == $id}.map{|price|Integer(price.instance_variable_get(:@total))}[i] 
                end
                $history << History.new($id, $many_user.map{|id|Integer(id.id)}[0], Date.today, $price_tot)
                $id+=1
                
                driverOnRoad($shop_id)
            end
        end
        
    end
end

def driverOnRoad(shop_id)
    shop_pos = $many_shop.select{|pos|pos.id == "#{shop_id}"}.map{|pos|Integer(pos.instance_variable_get(:@position))}[0]
    a = 0
    drv_name = ""
    for i in 0..4
        drv_pos = $many_driver.select{|drv|drv.id == "#{i}"}.map{|pos|Integer(pos.instance_variable_get(:@position))}[0]
        if drv_pos > shop_pos
            if a>0
                if drv_pos - shop_pos < a
                    a = drv_pos - shop_pos
                    drv_name = $many_driver.select{|drv|drv.id == "#{i}"}.map{|pos|pos.instance_variable_get(:@name)}[0]
                end
            else
                a = drv_pos - shop_pos
                drv_name = $many_driver.select{|drv|drv.id == "#{i}"}.map{|pos|pos.instance_variable_get(:@name)}[0]
            end
        else
            if a>0
                if shop_pos - drv_pos < a
                    a = drv_pos - shop_pos
                    drv_name = $many_driver.select{|drv|drv.id == "#{i}"}.map{|pos|pos.instance_variable_get(:@name)}[0]
                end
            else
                a = shop_pos - drv_pos
                drv_name = $many_driver.select{|drv|drv.id == "#{i}"}.map{|pos|pos.instance_variable_get(:@name)}[0]
            end
        end
    end
    puts a
    print drv_name, " will take your food\n"
end

def showHistory()
    p $history
    # $show_to_hist = Array.new([])
    # for i in 0..$history.select{|id|}
    #     $id_trans = $history.select{|id|id.id == i}.map{|id|id.instance_variable_get(:@id)[0]}
    #     print $id_trans
    #     print "\n"
    #     for j in 0..$many_history.select{|id|id.id_hist == $id_trans}.count-1
    #         $name = $many_history.select{|id|id.id == j and id.id_hist == $id_trans}.map{|name|name.instance_variable_get(:@menu)[0]}
    #         $price = $many_history.select{|id|id.id == j and id.id_hist == $id_trans}.map{|name|name.instance_variable_get(:@price)[0]}
    #         $quantity = $many_history.select{|id|id.id == j and id.id_hist == $id_trans}.map{|name|name.instance_variable_get(:@quantity)[0]}
    #         $total = $many_history.select{|id|id.id == j and id.id_hist == $id_trans}.map{|name|name.instance_variable_get(:@total)[0]}
            
    #         print $name
    #         print "\n"
    #         print $price
    #         print "\n"
    #         print $quantity
    #         print "\n"
    #         print $total
    #         print "\n"
    #     end
    #     $total_price = $history.select{|id|id.id == i}.map{|id|id.instance_variable_get(:@price)[0]}
    #     print $total_price
    #     print "\n"
    # end
end

x = 0
while x!=3
    printMap()
    print "Please select your order\n1. Order Food\n2. Show History\n3. Exit\n"
    x = gets.chomp!.to_i
    case x
    when 1
        chooseStore()
    when 2
        showHistory()
    else
        break
    end
end
# end
# name = gets.chomp
# p many_driver
# p many_shop
# p many_food
