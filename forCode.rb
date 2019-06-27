def add(a, c)
    return a+c
end

def time(a, c)
    return a*c
end
i = 0

while i!=4
a = gets.chomp
b = gets.chomp
i = gets.chomp!.to_i

case i
when 1
    puts add(a.to_i, b.to_i)
when 2
    time(a.to_i, b.to_i)
else
    break
end
end
