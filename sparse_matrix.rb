require 'set'

class GameOfLife64

    def initialize(live_cells = "")
      # Initialize live cells in the sparse matrix using 64-bit signed integers
      alive = Set.new
      $stdin.each_line do |line|
        next if line.strip.empty? || line.start_with?("#") # Skip comments and empty lines
        x, y = line.split.map(&:to_i)
        alive.add([x, y])
      end

      @live_cells = alive.to_h { |cell| [cell, true] }

      # not sure if this is where I want to call this
      board_area
    end

    def board_area
      # set the local vars to store min/max
      min_x = 0
      min_y = 0
      max_x = 0
      max_y = 0

      # find the extreems of x and y values from the initalized list
      @live_cells.map { |coord|

        # x value
        if coord[0][0] < min_x then min_x = coord[0][0] end
        if coord[0][0] > max_x then max_x = coord[0][0] end

        # y value
        if coord[0][1] < min_y then min_y = coord[0][1] end
        if coord[0][1] > max_y then max_y = coord[0][1] end
      }


      # figure out which one is bigger in absolutes
      x = 0
      y = 0

      min_x.abs > max_x.abs ? x = min_x.abs : x = max_x.abs
      min_y.abs > max_y.abs ? y = min_y.abs : y = max_y.abs

      # find which if x or y is larger
      max = 0

      x > y ? max = x : max = y


      @boundary = [max * -1, max]

      # i'm not sure if this is actuall relevant
      # double max (to deal with negatives) and set the board size
      @board_size = [ max*2, max*2 ]

    end

    def tick!
      new_live_cells = {}
      # create  new has with the default value of 0
      potential_cells = Hash.new(0)

      # Process each live cell and increment neighbor counts
      @live_cells.keys.each do |(x, y)|
        potential_cells[[x, y]] += 0
        neighbors(x, y).each { |nx, ny| potential_cells[[nx, ny]] += 1 }
      end

      # Apply the Game of Life rules
      potential_cells.each do |cell, count|
        if count == 3 || (count == 2 && @live_cells[cell])

          new_live_cells[cell] = true
        end
      end

      # check if the cell is in the boundary

      @live_cells = boundary_check(new_live_cells)
    end

    def boundary_check(cells)

      #get the boundaryies and set the min/max
      min = @boundary[0]
      max = @boundary[1]

      puts "min"
      puts min
      puts "max"
      puts max

      return cells.select { |cell|
        puts "cell"
        puts cell

        x = cell[0]
        y = cell[1]

        if x.between?(min, max) && y.between?(min, max) then true  end

      }


    end

    # set a sensible default but make it easy to change filenames
    def print_output(filename="64.life")
      # create the standard life format
      File.open(filename, 'w') do |file|
        file.puts("#Life 1.06")
        @live_cells.keys.each do |x, y|
          file.puts("#{x} #{y}")
        end
      end
    end

    def live_cells
      @live_cells.keys
    end

    def board_size
      @board_size
    end

    private

    def neighbors(x, y)
      [[x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
       [x, y - 1],                 [x, y + 1],
       [x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
    end
  end

