class TicTacToe
  attr_accessor :board

  def initialize
    @board = buildboard
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