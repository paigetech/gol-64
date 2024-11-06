# require './gol'

# gol = GameOfLife.new
# gol.loop

require './sparse_matrix'

# Initialize with some live cells using large 64-bit signed integer coordinates
# game = GameOfLife64.new([[-9_223_372_036_854_775_808, 0], [0, 9_223_372_036_854_775_807], [1, 1], [1, 0], [0, 1], [1, 2], [2, 1]])

# we need a handler to get this from standard in

game = GameOfLife64.new($stdin)

# Run a generation
game.tick!

# Display current live cells
puts "Live cells: #{game.live_cells.inspect}"
