require 'enumerator'
file = File.read("day1.txt")
# 12 red cubes, 13 green cubes, and 14 blue cubes


def in_groups_of(array, n)
    result = [[]]
    (0..(array.length - 1)).each do |i|
        result.last.append(array[i])
        if i % n == n-1
            result.append([])
        end        
    end
    if result.last.empty?
        return result[0, result.length - 1]
    end
    result
end


# returns 0 if the game is possible- id of game otherwise
def possible_or_id(game)
    tr = 12
    tg = 13
    tb = 14

    parts = game.split(" ")
    game_id = parts[1].to_i
   
    in_groups_of(parts[2,parts.length], 2).each do |part|
        count = part[0].to_i
        if part[1].include?("red")
            if count > tr
                puts ["hi", part, game_id].to_s
                return 0
            end
        end
        if part[1].include?("green")
            if count > tg
                puts ["hi", part, game_id].to_s
                return 0
            end
        end
        if part[1].include?("blue")
            if count > tb
                puts ["hi", part, game_id].to_s
                return 0
            end
        end
    end
    return game_id
end

def min_cubes(game)
    max_red = 1
    max_green = 1
    max_blue = 1

    parts = game.split(" ")
    in_groups_of(parts[2,parts.length], 2).each do |part|
        count = part[0].to_i
        if part[1].include?("red")
            max_red = [max_red, count].max
        end
        if part[1].include?("green")
            max_green = [max_green, count].max
        end
        if part[1].include?("blue")
            max_blue = [max_blue, count].max
        end
    end
    puts max_red.to_s + " " + max_green.to_s + " " + max_blue.to_s
    return max_red * max_green * max_blue
end


file = File.read("day2.txt")

sum = 0
file.split("\n").each do |line|
    sum += min_cubes(line)
    puts sum
end
