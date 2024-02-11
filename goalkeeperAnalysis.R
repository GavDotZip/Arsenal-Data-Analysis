# Load the readxl package
library(readxl)
library(tidyverse)
library(tidytext)
library(ggplot2)

# File paths for dataset
goalkeepers <- "datasets/goalkeepers.xlsx"

# Read data from Excel files
goalkeeperData <- read_excel(goalkeepers)

if (!is.null(goalkeeperData)) {
  
  # Display summary of players data
  cat("\nSummary of Players Data:\n")
  print(summary(goalkeeperData))
  
} else {
  cat("Error: Failed to load data from one or more files.\n")
}