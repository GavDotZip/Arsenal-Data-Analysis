# Load the readxl package
library(readxl)

# File paths for datasets
goalkeepers <- "datasets/goalkeepers.xlsx"
matches <- "datasets/matches.xlsx"
players <- "datasets/players.xlsx"

# Read data from Excel files
goalkeeperData <- read_excel(goalkeepers)
matchData <- read_excel(matches)
playerData <- read_excel(players)

# Check if data is loaded correctly
if (!is.null(goalkeeperData) && !is.null(matchData) && !is.null(playerData)) {
  
  # Display summary of matches data
  cat("Summary of Matches Data:\n")
  print(summary(matchData))
  
  # Display summary of players data
  cat("\nSummary of Players Data:\n")
  print(summary(playerData))
  
  # Display summary of goalkeepers data
  cat("\nSummary of Goalkeepers Data:\n")
  print(summary(goalkeeperData))
} else {
  cat("Error: Failed to load data from one or more files.\n")
}

