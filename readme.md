# Conways Game of Life, 1.06 in Ruby
This is my attempt at implementing the Game of Life within roughly 3 hours for the Riot take home interview exercise.

In writing this, I have made a few strong choices:
- I decided to implement using a sparse matrix approach to avoid running through massive grids
- The game sets a board boundary based on the initial input so we don't face an infinitely expanding board problem
- I am leaning on the fact that ruby integers are well suited to handling 64 bit signed integers
- I wrote this in a mostly TDD driven manner since I am somewhat rusty and this has been a great tool for me to keep things clear and bug free (or at least bug light)

To use this, pass the standard format to `run.rb` via standard input. This will output a `64.life` file which represents 10 generations of the game. 

In this set of files you'll find:
- a `run.rb` that is used to run the ruby class in the way the prompt requests output
- a `sparse_matrix.rb` file that implements input handling, runing the game of life logic and printing the output
- setup to run rspec specs and the `sparse_matrix_spec.rb` file
- a `nodemon.json` that is used to run the script when changes are saved


## example inputs
These are examples of how you can pass the input to the run script via standard input.

`echo -e "#Life 1.06\n0 1\n1 2\n2 0\n2 1\n2 2\n-2000000000000 -2000000000000\n-2000000000001 -2000000000001\n-2000000000000 -2000000000001" | ruby run.rb`
_with larger signed integers:_
`echo -e \"#Life 1.06\n-9_223_372_036_854_775_808 0\n -9_223_372_036_854_775_807 -1\n -9_223_372_036_854_775_807 0\n -9_223_372_036_854_775_807 1\n1 9_223_372_036_854_775_807\n0 1\n0 -10\n9 0\" | ruby run.rb`



## Game of Life Prompt (due two days prior to Broad Tech Interview)
### Implement Conway's Game of Life in 64-bit signed integer space.

Imagine a 2D grid - each cell (coordinate) can be either "alive" or "dead". Every generation of the simulation, the system ticks forward. Each cell's value changes according to the following:

If an "alive" cell had less than 2 or more than 3 alive neighbors (in any of the 8 surrounding cells), it becomes dead.
If a "dead" cell had *exactly* 3 alive neighbors, it becomes alive.
Your input is a list of integer coordinates for live cells in the Life 1.06 format. They could be anywhere in the signed 64-bit range. This means the board could be very large!

Sample input:

#Life 1.06

0 1

1 2

2 0

2 1

2 2

-2000000000000 -2000000000000

-2000000000001 -2000000000001

-2000000000000 -2000000000001

Your program should read the state of the simulation from standard input, run 10 iterations of the Game of Life, and print the result to standard output in Life 1.06 format.

Please don’t spend more than 3 hours on your solution. Feel free to allocate that time in a manner that works best for your schedule. You may work in any language you prefer.

We're most interested in both the technical aspects of how you deal with very large integers and how you go about solving the problem. At the onsite, be prepared to discuss your solution, including the choices and tradeoffs you made. Though not required, you are welcome to bring a laptop with you to your interview to walk us through the code.
