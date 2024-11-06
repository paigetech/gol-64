#spec/gol_spec.rb
require 'rspec'
require 'set'
require 'stringio'
require './sparse_matrix'


describe GameOfLife64 do

    describe "#inialize" do
        it "parses a standard input into the live cells array key value store" do

            gol = GameOfLife64.new

              # Simulate input data as if it were coming from $stdin
              input_data = "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n"
              $stdin = StringIO.new(input_data)

              live_cells = gol.initialize

            expected_cells = Set.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])

            expect(live_cells).to eql(expected_cells)

        ensure
          $stdin = STDIN # reset $stdin to its original state
        end
    end

end
