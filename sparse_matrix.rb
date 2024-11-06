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

      # this is set up to take a set, kinda
      @live_cells = alive.to_h { |cell| [cell, true] }
    end

    def tick!
      puts "----------tick!----------"
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

      @live_cells = new_live_cells
    end

    def live_cells
      @live_cells.keys
    end

    private

    def neighbors(x, y)
      [[x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
       [x, y - 1],                 [x, y + 1],
       [x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
    end
  end

