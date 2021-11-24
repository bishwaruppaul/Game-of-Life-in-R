# Game-of-Life-in-R
Conway's Game of Life, created using R

### Links:
Conway's Game of Life: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

R Project: https://www.r-project.org/

YouTube video of the result: https://youtu.be/jLCh5w9e7Qk

### Steps in the code:
1. Create an empty matrix of 100 rows and 100 columns
2. Randomly fill 20% cells with 1, rest with 0 (1 depicting cells are in 'alive' state, 0 depicting they are in 'dead' state)
3. Calculate the number of neighbouring alive cells surrounding each cell of the matrix.
4. Follow Game of Life rules to update the state of each cell to dead/alive in the next generation, based on the number of neighbouring alive cells.
5. Repeat this for 1000 generations.
6. Save the matrix as a plot in each generation as an image, creating an image sequence.
7. Convert the image sequence to video/gif.
