class Array
  def my_uniq
    uniques = []
    self.each { |num| uniques << num unless uniques.include?(num) }
    uniques
  end
end

class Array
  def two_sum
    pair = []
    length.times do |i1|
      length.times do |i2|
        next if i2 <= i1

        pair << [i1, i2] if self[i1] + self[i2] == 0
      end
    end
    pair
  end
end

class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = Array.new(3) { [] }
    @towers[0] = [3, 2, 1]
  end

  def get_move
    puts "what's your move"
    input = gets.chomp.split
    input.map! { |value| value.to_i }
  end

  def valid_move?(move)
    return false if move.length != 2
    move.each do |num|
      return false if num > 2 || num < 0
    end
  end

  def make_move(move)
    start_tower = @towers[move[0]]
    end_tower = @towers[move[1]]
    end_tower << start_tower.pop
  end
end

