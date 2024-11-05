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

  def loop
    puts "----------loop----------"
    @input

  end

  def rules
    
    true

  end


end

gol = GameOfLife.new
gol.loop