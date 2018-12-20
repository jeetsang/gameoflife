class Board
  def initialize(m, n)
    @cells_grid = Array.new(m) {Array.new(n, 0)}
    @row = m
    @col = n
    #
    # @cells_grid[0][1] = 1
    # @cells_grid[1][2] = 1
    # @cells_grid[2][0] = 1
    # @cells_grid[2][1] = 1
    # @cells_grid[2][2] = 1
    randomize_life
  end

  def display
    puts("Game state")
    @cells_grid.each do |cellRow|
      cellRow.each do |cell|
        # print(cell)
        if cell.zero?
          print(' ')
        else
          print('*')
        end
      end
      print("\n")
    end
  end

  def goto_next_state
    duplicateCells = deep_copy(@cells_grid)

    @cells_grid.each_with_index do |row, row_index|
      row.each_with_index do |val, col_index|
        live_neighbour_count = get_live_neighbour_count(row_index, col_index)
        duplicateCells[row_index][col_index] = 0 if @cells_grid[row_index][col_index] == 1 && live_neighbour_count < 2
        duplicateCells[row_index][col_index] = 0 if @cells_grid[row_index][col_index] == 1 && live_neighbour_count > 3
        duplicateCells[row_index][col_index] = 1 if @cells_grid[row_index][col_index] == 0 && live_neighbour_count == 3
      end
    end

    @cells_grid = duplicateCells
  end

  private

  def randomize_life
    ((@row*@col)/2).times do ||
      row_index = rand(0..(@row - 1))
      col_index = rand(0..(@col - 1))
      @cells_grid[row_index][col_index] = 1
    end

  end

  def get_live_neighbour_count(row, col)
    count = 0
    count += 1 if valid_index(row - 1, col - 1) && @cells_grid[row - 1][col - 1] == 1
    count += 1 if valid_index(row - 1, col) && @cells_grid[row - 1][col] == 1
    count += 1 if valid_index(row - 1, col + 1) && @cells_grid[row - 1][col + 1] == 1
    count += 1 if valid_index(row, col - 1) && @cells_grid[row][col - 1] == 1
    count += 1 if valid_index(row, col + 1) && @cells_grid[row][col + 1] == 1
    count += 1 if valid_index(row + 1, col - 1) && @cells_grid[row + 1][col - 1] == 1
    count += 1 if valid_index(row + 1, col) && @cells_grid[row + 1][col] == 1
    count += 1 if valid_index(row + 1, col + 1) && @cells_grid[row + 1][col + 1] == 1
    count
  end

  def valid_index(row, col)
    row >= 0 && row < @row && col >= 0 && col < @col
  end

  def deep_copy array
    Marshal.load( Marshal.dump(array) )
  end
end