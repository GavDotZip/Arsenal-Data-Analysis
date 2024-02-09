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
  # Display a summary of matches data
  cat("Summary of Matches Data:\n")
  print(summary(matchData))
} else {
  cat("Error: Failed to load data from one or more files.\n")
}
