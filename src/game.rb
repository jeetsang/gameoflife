require '../src/board'

class Game
  def initialize(m = 4, n = 3)
    @initial_board = Board.new(m, n)
  end

  def start
    @initial_board.display
    # @initial_board.goto_next_state
    # @initial_board.display

    20.times { ||
      @initial_board.goto_next_state
      @initial_board.display
    }
  end
end