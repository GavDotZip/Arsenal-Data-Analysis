# Load the readxl package
library(readxl)
library(tidyverse)
library(tidytext)
library(ggplot2)

# File paths for dataset
matches <- "datasets/matches.xlsx"

# Read data from Excel files
matchData <- read_excel(matches)

if (!is.null(matchData)) {
  
  # Display summary of players data
  cat("\nSummary of Players Data:\n")
  print(summary(matchData))
  
} else {
  cat("Error: Failed to load data from one or more files.\n")
}
