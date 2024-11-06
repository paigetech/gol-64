#spec/gol_spec.rb
require 'rspec'
require 'set'
require 'stringio'
require 'tempfile'
require './sparse_matrix'


describe GameOfLife64 do

    describe "#inialize" do
        it "parses a standard input into the live cells array key value store" do
            # Simulate input data as if it were coming from $stdin
            input_data = "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n"
            $stdin = StringIO.new(input_data)

            gol = GameOfLife64.new

            expected_cells = Set.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])

            expect(gol.live_cells).to match_array(expected_cells)

        ensure
          $stdin = STDIN # reset $stdin to its original state
        end
    end

    describe "#tick!" do

      it "it brings new cells to life" do
          # Simulate input data as if it were coming from $stdin
          input_data = "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n"
          $stdin = StringIO.new(input_data)

          gol = GameOfLife64.new

          expected_cells = Set.new([[1, 0], [1, 2], [2, 1], [2, 2]])
          gol.tick!

          expect(gol.live_cells).to match_array(expected_cells)

      end

      it "it kill cells that are overcrowded" do
          # change input data to get an overcrowding scenario
          input_data = "#Life 1.06\n0 0\n1 0\n0 1\n1 1\n1 2\n"
          $stdin = StringIO.new(input_data)

          gol = GameOfLife64.new

          expected_cells = Set.new([[0, 0], [1, 0], [1, 2], [0, 2], [1, 2], [2, 1]])
          gol.tick!

          expect(gol.live_cells).to match_array(expected_cells)

      end

      it "it keeps cells that have 2 or 3 neighbors" do
          # change input data to get an overcrowding scenario
          input_data = "#Life 1.06\n1 1\n2 1\n1 2\n1 4\n"
          $stdin = StringIO.new(input_data)

          gol = GameOfLife64.new

          expected_cells = Set.new([[1, 1], [2, 1], [1, 2], [2, 2]])
          gol.tick!

          expect(gol.live_cells).to match_array(expected_cells)

      end


        it 'can tick multiple times' do
        # Set up the game with a known state
        # Simulate input data as if it were coming from $stdin
        input_data = "#Life 1.06\n-10 -10\n-9 -10\n-8 -10\n-9 -9\n"
        $stdin = StringIO.new(input_data)

        gol = GameOfLife64.new

        3.times { gol.tick! }

        expected_cells = Set.new([[-10, -9], [-9, -8], [-8, -9]])

        expect(gol.live_cells).to match_array(expected_cells)
        end
        describe '#board_area' do

  end
    describe '#boundary_check' do
            # this introduces the going off the board problem
            it "it does not alow new cells off the board" do
            # change input data to get an overcrowding scenario
            input_data = "#Life 1.06\n-10 -10\n-9 -10\n-8 -10\n"
            $stdin = StringIO.new(input_data)

            gol = GameOfLife64.new

            #need to update this with new undersanding
            expected_cells = Set.new([[-9, -10], [-9, -9]])
            gol.tick!

            expect(gol.live_cells).to match_array(expected_cells)

        end
    end
  describe '#save_to_file' do
    it "sets the correct board size" do
        # change input data to get an overcrowding scenario
        input_data = "#Life 1.06\n4 0\n1 0\n0 1\n0 -10\n"
        $stdin = StringIO.new(input_data)

        gol = GameOfLife64.new

        expected_board_area = [20, 20]

        expect(gol.board_size).to match_array(expected_board_area)

    end
  end 

  describe '#save_to_file' do
      it 'saves the current live cells to a file in Life 1.06 format' do
        # Set up the game with a known state
        # Simulate input data as if it were coming from $stdin
        input_data = "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n"
        $stdin = StringIO.new(input_data)
  
        gol = GameOfLife64.new
  
        # Create a temporary file to save the output
        # this temp thing isn't working
        Tempfile.open('game_of_life_test') do |file|
          gol.print_output(file.path)
  
          # Read the contents of the file
          file.rewind
          output = file.read
  
          # Define the expected output
          expected_output = <<~LIFE
            #Life 1.06
            0 1
            1 2
            2 0
            2 1
            2 2
          LIFE
  
          # Check that the file contents match the expected format
          expect(output).to eq(expected_output)
        end
      end
    end
  end
ensure
    $stdin = STDIN # reset $stdin to its original state
end



