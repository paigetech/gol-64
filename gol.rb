require 'set'

class GameOfLife

  def input
    puts "----------input----------"
    live_cells = Set.new
    $stdin.each_line do |line|
      next if line.strip.empty? || line.start_with?("#") # Skip comments and empty lines
      x, y = line.split.map(&:to_i)
      live_cells.add([x, y])
    end
    # live cell results
    puts live_cells
    live_cells
  end

  def min_max(live_cells)
    # find the highest and lowest integer to determine the board size
    # i need live_cells from input
    puts "----------size----------"
    max_x = 0
    max_y = 0
    min_x = 0
    min_y = 0
      puts "-------------size live_cells---------------"
      puts live_cells


    live_cells.map { |chord|
      puts "-------------chord---------------"
      puts chord
      # these are coming in as pairs
      if chord[0] > max_x then  max_x = chord[0] end
      if chord[0] < min_x then  min_x = chord[0] end

      if chord[1] > max_y then  max_y = chord[1] end
      if chord[1] < min_y then  min_y = chord[1] end
    }

    # should i change this to a set?
    # a hash?
    result = [max_x, min_x, max_y, min_y]

    return result

  end


  def board_size(min_max)

    # now we have the min max in the initial set
    # we can find the board size with some math

    # key min_max = [max_x, min_x, max_y, min_y]
    board_width= (min_max[0] - min_max[1]).abs
    board_height = (min_max[2] - min_max[3]).abs

    total_size = [board_width, board_height].max

    return [total_size, total_size]

  end

  def rules
    # just for the tests for now
    true
  end

  def loop
    puts "----------loop----------"
    board_size(min_max(input))

  end



end
