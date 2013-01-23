module Reversi

  class Tile
    ADJACENTS = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]

    attr_reader :color

    def initialize(color)
      @color = color
    end

    def flip
      return @color = :r if @color == :b
      return @color = :b if @color == :r
    end

    def self.adjacents
      ADJACENTS
    end
  end

  class Player
    attr_reader :color

    def initialize(color, game)
      @color = color
      @game = game
    end

    def move(r, c)
      @game.take_move([r, c], self)
      [r, c]
    end

  end

  class Game

    STARTING_REDS = [[3, 3], [4, 4]]
    STARTING_BLUES = [[3, 4], [4, 3]]

    attr_reader :board

    def initialize
      @board = Array.new(8) { Array.new(8) }

      STARTING_REDS.map { |r, c| @board[r][c] = Tile.new(:r) }
      STARTING_BLUES.map { |r, c| @board[r][c] = Tile.new(:b) }
    end

    def pick_tile(player)
      Tile.new(player.color)
    end

    def valid_position?(coords)
      r, c = coords
      r < 8 && r >= 0 && c < 8 && c >= 0
    end

    def take_move(player, coords)
      raise "Not on board" unless valid_position?(coords)
      r, c = coords
      @board[r][c] = pick_tile(player)
    end

    def find_adjacents(coords)
      Tile.adjacents.map do |adj_r, adj_c|
        tile_r, tile_c = coords
        [adj_r + tile_r, adj_c + tile_c]
      end.select { |coords| valid_position?(coords) }
    end

  end
end















