digits = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

file = File.read("day1.txt")
result = file.split().map do |line|
  startword = -1
  endword = -1
  s = -1
  e = -1

  digits.keys.each do |key|
    i = line.index(key)
    l = line.rindex(key)
    if !i.nil?
      if startword == -1 or i < startword
        startword = i
        s = digits[key]
      end

      if endword == -1 or l > endword
        endword = l
        e = digits[key]
      end
    end
  end
  
  chars = line.split("")
  for i in 0..chars.length-1
    char = chars[i]
    if char.match(/[0-9]/)
      if s == -1 or i < startword
        s = char.to_i
        startword = i
      end
      if e == -1 or i > endword
        e = char.to_i
        endword = i
      end
    end
  end

  if s == -1 or e == -1
    puts "Error!!!"
    puts line
  end
  s * 10 + e
end
puts result.sum()


