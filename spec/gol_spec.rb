#spec/gol_spec.rb
require 'set'
require './gol'


describe GameOfLife do
  describe "#input" do
    it "it parses Life 1.06 input correctly" do
      gol = GameOfLife.new

      input_data = "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n"

      # mock stdin
      allow($stdin).to receive(:each_line).and_return(input_data.each_line)

      live_cells = gol.input

      expected_cells = Set.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])

      expect(live_cells).to eql(expected_cells)
    end
  end

  describe "#rules" do
    it "true" do
      gol = GameOfLife.new
      expect(gol.rules).to eql(true)
    end
  end

end