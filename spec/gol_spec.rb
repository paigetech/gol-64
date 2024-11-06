#spec/gol_spec.rb
require 'rspec'
require 'set'
require 'stringio'
require './gol'


describe GameOfLife do

  describe "#input" do
    it "parses Life 1.06 input correctly" do
      gol = GameOfLife.new

      # Simulate input data as if it were coming from $stdin
      input_data = "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n"
      $stdin = StringIO.new(input_data)

      live_cells = gol.input

      # Restore original $stdin after the test
      expected_cells = Set.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])

      expect(live_cells).to eql(expected_cells)
    ensure
      $stdin = STDIN # Make sure to reset $stdin to its original state
    end
  end

  describe "#min_max" do
    it "it finds the highest and lowest values in the set" do
      gol = GameOfLife.new

      input_data = "#Life 1.06\n-1000 1\n1 2\n2 0\n2 1300\n2 2\n"
      $stdin = StringIO.new(input_data)

      result = gol.min_max(gol.input)

      expected_result= [-1000, 0, 2, 1300]

      expect(result).to match_array(expected_result)
    end
  end

  describe "#board_size" do
    it "it finds the size of the board" do
      gol = GameOfLife.new

      input_data = "#Life 1.06\n-1000 1\n1 2\n2 0\n2 1300\n2 2\n"
      $stdin = StringIO.new(input_data)

      board = gol.board_size(gol.min_max(gol.input))

      expected_board= [1300, 1300]

      expect(board).to match_array(expected_board)
    end
  end

  describe "#rules" do
    it "true" do
      gol = GameOfLife.new
      expect(gol.rules).to eql(true)
    end
  end

end
