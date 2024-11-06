require './sparse_matrix'

# Initialize with some live cells using large 64-bit signed integer coordinates

game = GameOfLife64.new($stdin)

# Run a generation
10.times { game.tick! }

# TODO: checking for a file or using time stamps to make new ones
game.print_output()

# Display current live cells
puts "Live cells: #{game.live_cells.inspect}"
