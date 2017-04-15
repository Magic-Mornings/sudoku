class Sudoku

attr_accessor :puzzle_one, :puzzle_two, :puzzle_three, :puzzle_four, :solution_one, :solution_two, :solution_three, :solution_four

  def initialize
    @puzzle_one = [
        [0,9,0,2,0,7,0,0,0],
        [8,1,0,0,0,0,6,0,0],
        [0,0,7,0,0,4,0,3,0],
        [0,8,0,7,1,0,0,0,0],
        [0,0,5,4,0,0,0,0,0],
        [3,0,0,0,0,0,0,9,0],
        [0,0,0,0,0,0,8,0,6],
        [4,0,0,0,0,0,0,1,0],
        [5,0,0,0,0,2,0,0,0]
      ]

    @solution_one = [
        [6,9,3,2,8,7,1,5,4],
        [8,1,4,9,3,5,6,2,7],
        [2,5,7,1,6,4,9,3,8],
        [9,8,2,7,1,3,4,6,5],
        [1,7,5,4,9,6,2,8,3],
        [3,4,6,5,2,8,7,9,1],
        [7,2,9,3,5,1,8,4,6],
        [4,3,8,6,7,9,5,1,2],
        [5,6,1,8,4,2,3,7,9]
      ]

    @puzzle_two = [
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,5,3,0,6,0,0],
        [1,5,0,0,2,0,0,0,4],
        [0,0,3,6,0,0,0,8,0],
        [0,4,0,0,0,2,3,0,0],
        [2,0,0,0,0,0,0,6,0],
        [0,0,6,8,0,0,0,0,0],
        [0,0,5,0,9,4,0,0,0],
        [9,0,4,0,0,0,0,0,1]
      ]

    @solution_two = [
        [3,6,2,4,7,8,5,1,9],
        [4,9,7,5,3,1,6,2,8],
        [1,5,8,9,2,6,7,3,4],
        [5,7,3,6,4,9,1,8,2],
        [6,4,1,7,8,2,3,9,5],
        [2,8,9,1,5,3,4,6,7],
        [7,2,6,8,1,5,9,4,3],
        [8,1,5,3,9,4,2,7,6],
        [9,3,4,2,6,7,8,5,1]
      ]

    @puzzle_three = [
        [0,1,9,0,0,3,2,0,0],
        [4,6,0,0,0,0,0,0,0],
        [0,8,3,0,4,0,0,0,5],
        [0,0,5,9,0,0,1,4,0],
        [0,0,0,2,0,0,0,0,0],
        [0,4,0,0,0,8,0,0,0],
        [0,0,6,0,0,0,8,0,0],
        [0,0,0,0,7,6,0,5,3],
        [0,0,7,0,0,5,0,0,0],
      ]

    @solution_three = [
        [5,1,9,6,8,3,2,7,4],
        [4,6,2,7,5,9,3,8,1],
        [7,8,3,1,4,2,6,9,5],
        [2,3,5,9,6,7,1,4,8],
        [6,7,8,2,1,4,5,3,9],
        [9,4,1,5,3,8,7,6,2],
        [3,5,6,4,9,1,8,2,7],
        [1,2,4,8,7,6,9,5,3],
        [8,9,7,3,2,5,4,1,6]
      ]

    @puzzle_four = [
        [0,0,1,0,0,0,2,8,0],
        [0,5,0,0,1,6,0,0,0],
        [9,0,0,0,7,0,1,4,0],
        [6,0,0,7,2,0,0,0,0],
        [0,0,0,0,0,3,0,1,0],
        [0,2,0,0,4,0,0,0,0],
        [4,0,9,0,3,2,0,0,0],
        [0,0,0,8,0,4,0,0,7],
        [3,6,0,9,5,0,0,0,0]
      ]

    @solution_four = [
        [7,4,1,3,9,5,2,8,6],
        [8,5,2,4,1,6,3,7,9],
        [9,3,6,2,7,8,1,4,5],
        [6,8,3,7,2,1,5,9,4],
        [5,9,4,6,8,3,7,1,2],
        [1,2,7,5,4,9,8,6,3],
        [4,7,9,1,3,2,6,5,8],
        [2,1,5,8,6,4,9,3,7],
        [3,6,8,9,5,7,4,2,1]
      ]
  end

  def solve(puzzle)
    loop do
      puzzle.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          next unless cell == 0
          puzzle[y][x] = solve_cell(puzzle,y,x)
          puzzle.each { |row | p row }
        end
      end
      break unless puzzle.flatten.include?(0)
    end
  end

  def solve_cell(puzzle,y,x)
    all_neighbors = row_neighbors(puzzle, y) + col_neighbors(puzzle, x) + square_neighbors(puzzle, x, y)
    possible_answers = [1,2,3,4,5,6,7,8,9]
    trimmed_answers = possible_answers - all_neighbors
    # p all_neighbors
    # p trimmed_answers
    trimmed_answers.length == 1 ? trimmed_answers[0] : 0
  end

  def row_neighbors(puzzle,row)
    puzzle[row] - [0]
  end

  def col_neighbors(puzzle,col)
    puzzle.transpose[col] - [0]
  end

  def square_neighbors(puzzle,x,y)
    quadrents = build_squares(puzzle)
    quadrents.each do |quad|
      return quad[:values] - [0] if quad[:x].include?(x) && quad[:y].include?(y)
    end
  end

  def build_squares(puzzle)
    quadrents = [
      {x: [0,1,2], y: [0,1,2], values: []},
      {x: [0,1,2], y: [3,4,5], values: []},
      {x: [0,1,2], y: [6,7,8], values: []},
      {x: [3,4,5], y: [0,1,2], values: []},
      {x: [3,4,5], y: [3,4,5], values: []},
      {x: [3,4,5], y: [6,7,8], values: []},
      {x: [6,7,8], y: [0,1,2], values: []},
      {x: [6,7,8], y: [3,4,5], values: []},
      {x: [6,7,8], y: [6,7,8], values: []}
    ]
    quadrents.each do |quad|
      quad[:x].each do |x|
        quad[:y].each do |y|
          quad[:values] << puzzle[y][x]
        end
      end
    end
    quadrents
  end
end
