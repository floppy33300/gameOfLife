require_relative "Cell.rb"

class Board
  attr_reader :grid

  def initialize(grid)
    @grid = create_cells(grid)
    @rows = grid.length
    @columns = grid.first.length
  end

  def neighbors(x,y)
    neighbors_coords = [[x-1, y-1], [x-1, y], [x-1, y+1], [x, y-1], [x, y+1], [x+1, y-1], [x+1, y], [x+1, y+1]]
    neighbors_coords.select { |coords| coords[0] < @rows && coords[1] < @columns && coords[0] >= 0 && coords[1] >= 0 }
  end

  def count_alive_neighbors(x,y)
    alive_nunbers = 0
    coords = neighbors(x,y)
    coords.each do |c|
      alive_nunbers += 1 if @grid[c[0]][c[1]].alive?
    end
    alive_nunbers
  end


  def next_gen
    x = 0
    new_grid = []
    while x < @rows
      new_row = []
      y = 0
      while y < @columns
        if count_alive_neighbors(x, y) < 2
          new_row << Cell.new(0, x, y)
        elsif count_alive_neighbors(x,y) > 3
          new_row << Cell.new(0, x, y)
        elsif count_alive_neighbors(x,y) == 3
          new_row << Cell.new(1, x, y)
        else
          new_row << Cell.new(@grid[x][y].numb, x, y)
        end
        y += 1
      end
      new_grid << new_row
      x += 1
    end
    Board.new(new_grid)
  end

  def to_a
    new_a = []
    @grid.each do |row|
      new_row =[]
      row.each do |cell|
        new_row << cell.numb
      end
      new_a << new_row
    end
    new_a
  end

  private

  def create_cells(grid)
    grid.map!.with_index do |row, x|
      row.map!.with_index do |cell, y|
        Cell.new(cell, x, y)
      end
    end

  end
end


