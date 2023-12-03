
# s = "1245..."
# c = s.chars
# puts getNum(c, 0)
def getNum(chars, j)
  num = ""
  while chars[j] != "."
    num += chars[j]
    j += 1
  end
  [num.to_i, j]
end

SPECIAL = %w(! @ # $ % ^ & * ( ) + - = _ [ ] { } \\ | / , ; : ' " ~ `).freeze
DIGITS = %w(1 2 3 4 5 6 7 8 9 0).freeze

def adjacentToSymbol(j, current, prevl, nextl)
  adj = false
  if prevl != []
    adj = (SPECIAL.include?(prevl[j - 1]) or SPECIAL.include?(prevl[j]) or (SPECIAL.include?(prevl[j + 1])))
  end
  adj = (adj or (SPECIAL.include?(current[j - 1]) or SPECIAL.include?(current[j]) or (SPECIAL.include?(current[j + 1]))))
  if nextl != []
    adj = (adj or (SPECIAL.include?(nextl[j - 1]) or SPECIAL.include?(nextl[j]) or (SPECIAL.include?(nextl[j + 1]))))
  end
  adj
end

def getNum(line, j)
  startn = j
  endn = j

  while DIGITS.include?(line[startn])
    startn -= 1
  end
  startn += 1

  while DIGITS.include?(line[endn])
    endn += 1
  end

  num = ""
  (startn..endn-1).each do |i|
    num += line[i]
  end

  num
end

def appendIfNotNil(l, elem)
  if elem == "" or elem.nil?
    return l
  end
  l.append(elem)
  l
end

def getNumsAdjacent(j, current, prevl, nextl)
  nums = []
  appendIfNotNil(nums, getNum(current, j-1))
  appendIfNotNil(nums, getNum(current, j+1))

  if DIGITS.include?(prevl[j])
    nums.append(getNum(prevl, j))
  else
    appendIfNotNil(nums, getNum(prevl, j-1))
    appendIfNotNil(nums, getNum(prevl, j+1))
  end
  # puts "current: " + current[j]

  # puts "next: " + nextl[j]

  if DIGITS.include?(nextl[j])
    nums.append(getNum(nextl, j))
  else
    appendIfNotNil(nums, getNum(nextl, j-1))
    appendIfNotNil(nums, getNum(nextl, j+1))
  end
end

file = File.read("day3.txt")
lines = file.split

# lines = [
# "467..114..",
# "...*......",
# "..35..633.",
# "......#...",
# "617*......",
# ".....+.58.",
# "..592.....",
# "......755.",
# "...$.*....",
# ".664.598..",
# ]

s = 0
# puts getNumsAdjacent(3, ".12*34".chars,
#                      "......".chars,
#                      "..300.".chars).to_s

(0..lines.length).each do |i|
  l = (lines[i] or "")
  prevl = (lines[i-1] or "").chars
  nextl = (lines[i+1] or "").chars
  chars = l.chars
  (0..chars.length).each do |j|
    if chars[j] == "*"
      numsAdj = getNumsAdjacent(j, chars, prevl, nextl)
      puts numsAdj.to_s
      if numsAdj.length == 2
        s += numsAdj[0].to_i * numsAdj[1].to_i
      end
    end
  end
end

puts s

# lines = lines[lines.length-2, lines.length]

# lines = ["..69*861.."]

# lines = [
# "467..114..",
# "...*......",
# "..35..633.",
# "......#...",
# "617*......",
# ".....+.58.",
# "..592.....",
# "......755.",
# "...$.*....",
# ".664.598..",
# ]

# lines = [
#   "...$.*....",
#   ".664.598..",
# ]
# puts adjacentToSymbol(3, lines[1].chars, lines[0].chars, [])

# lines = [
# "......+...",
# ".......446",
# ]
# puts adjacentToSymbol(lines[1].length - 3, lines[1].chars, lines[0].chars, [])

#
# nums = []
# (0..lines.length).each do |i|
#   l = (lines[i] or "")
#   chars = l.chars
#   j = 0
#   num = ""
#
#   valid = false
#   prevl = (lines[i - 1] || "").chars
#   nextl = (lines[i + 1] || "").chars
#   while j < chars.length
#     if chars[j] != "." and (not SPECIAL.include?(chars[j]))
#       num += chars[j]
#
#       valid = (valid or adjacentToSymbol(j, chars, prevl, nextl))
#       if (j == chars.length - 1)
#         if num != "" and valid
#           nums.append(num.to_i)
#           valid = false
#
#         end
#       end
#     elsif (chars[j] == ".") or (SPECIAL.include?(chars[j]))  or (j == chars.length - 1)
#       # end of number
#       if num != "" and valid
#         nums.append(num.to_i)
#         valid = false
#         puts num
#       end
#
#       num = ""
#     end
#
#     j = j + 1
#   end
# end
# puts nums.sum



