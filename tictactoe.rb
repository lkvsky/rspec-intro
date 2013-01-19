class TicTacToe
  attr_accessor :board, :pieces

  def initialize
    @board = build_board
    @pieces = {1 => :x, 2 => :o}
  end

  def diagonals

  end

  def buildboard
    board = Array.new(3) do
      Array.new(3) { nil }
    end
  end

  def valid_move?(move)
    @board[move[0]][move[1]].nil?
  end

  def win?

  end
end

class HumanPlayer
  attr_accessor :piece, :game

  def initialize(player_num, game)
    @game = game
    @piece = @game.pieces[player_num]
  end

  def make_move
    puts "Where do you want to put your piece?"
    gets.chomp.split.map! { |num| num.to_i }
  end

end