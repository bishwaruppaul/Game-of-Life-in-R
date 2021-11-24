# Conway's Game of Life rules
# Any live cell with fewer than two live neighbours dies
# Any live cell with two or three live neighbours lives on to the next gen.
# Any live cell with more than three live neighbours dies.
# Any dead cell with exactly three live neighbours becomes a live cell

# Installing/Loading required libraries using pacman package
if (!require("pacman")) install.packages("pacman")
p_load(plot.matrix, gifski, av)

#------------------- Initial setup--------------------------------

# Number of rows/columns
n = 100

# Number of generations
genr = 1000

# Creating the first generation
# A matrix with randomly scattered 20% live cells
x <- matrix(nrow=n, ncol=n)

for (i in 1:n){
  for (j in 1:n){
    x[i,j] = sample(c(0,1), size=1, prob=c(0.8, 0.2))
  }
}

# Plotting the first gen
if (!dir.exists("plot")) dir.create("plot")
png(filename="plot/gen0001.png", width=600, height=600)
plot(x, asp=T, col=c('White', 'Black'), border=NA, key=NULL, 
     main="Gen 1", xlab="", ylab="")
dev.off()

#-------------------- Generations -------------------------------

# Progress Bar to display the progress of generations in console
pb <- txtProgressBar(min = 1, max = genr, initial = 2, style=3) 

# Looping through the generations
for (z in 2:genr){
  # x_next is a copy of original generation,
  # to be morphed in the new generation
  x_next <- x
  
  for (i in 1:n){
    for (j in 1:n){
      # Counting number of neighbours alive
      counter <- numeric(8)
      try(counter[1] <- x[i+1,j], silent=T)
      try(counter[2] <- x[i,j+1], silent=T)
      try(counter[3] <- x[i+1,j+1], silent=T)
      try(counter[4] <- x[i-1,j], silent=T)
      try(counter[5] <- x[i,j-1], silent=T)
      try(counter[6] <- x[i-1,j-1], silent=T)
      try(counter[7] <- x[i-1,j+1], silent=T)
      try(counter[8] <- x[i+1,j-1], silent=T)
      
      # Applying Game of Life rules
      if (sum(counter) == 2 & x[i,j] == 1){
        x_next[i,j] <- 1
      }
      if (sum(counter) == 3 & x[i,j] == 1){
        x_next[i,j] <- 1
      }
      if (sum(counter) < 2 & x[i,j] == 1){
        x_next[i,j] <- 0
      }
      if (sum(counter) > 3 & x[i,j] == 1){
        x_next[i,j] <- 0
      }
      if (sum(counter) == 3 & x[i,j] == 0){
        x_next[i,j] <- 1
      }
    }
  }
  
  # Formatting the file name sequence and plot title sequence
  # width = 4 because there are 1000 generations
  seq_form <- formatC(z, width=4, format="d", flag="0")
  file_name <- paste0("plot/gen",seq_form,".png")
  plot_title <- paste0("Gen ", z)
  
  # Plotting the current generation
  png(filename=file_name, width=600, height=600)
  plot(x_next, asp=T, col=c('White', 'Black'), border=NA, key=NULL, 
       main=plot_title, xlab="", ylab="")
  dev.off()
  
  # Updating the old generation to the new
  x <- x_next
  
  # Updating progress bar
  setTxtProgressBar(pb,z)
}

# Completing progress bar
close(pb)

#------------------ Stitching plots to a video -------------------

# Reading the images
png_path <- file.path("plot", "gen%04d.png")
png_files <- sprintf(png_path, 1:1000)

# Converting to GIF
gifski(png_files, "ConwayGOL.gif", delay = 0.04, loop=T, progress=T)

# Converting to video
av_encode_video(png_files, 'ConwayGOL.mp4', framerate = 25, verbose=T)


