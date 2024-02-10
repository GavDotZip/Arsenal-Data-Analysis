# Load the readxl package
library(readxl)

# File paths for dataset
players <- "datasets/players.xlsx"

# Read data from Excel files
playerData <- read_excel(players)

if (!is.null(playerData)) {
  
  # Display summary of players data
  cat("\nSummary of Players Data:\n")
  print(summary(playerData))
  
} else {
  cat("Error: Failed to load data from one or more files.\n")
}
