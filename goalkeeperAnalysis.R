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


# Aggregate total saves for each goalkeeper across all matches
total_saves <- goalkeeperData %>%
  group_by(FirstName, LastName) %>%
  summarise(TotalSaves = sum(Saves))

# Sort the data to get the top goalkeepers by total saves
top_goalkeepers <- total_saves %>%
  arrange(desc(TotalSaves)) %>%
  head(10)

# Print the top goalkeepers by total saves
cat("\nTop 10 Goalkeepers by Total Saves Across All Matches:\n")
print(top_goalkeepers)

# Create a bar chart for the top goalkeepers by total saves
plot_top_goalkeepers <- ggplot(top_goalkeepers, aes(x = reorder(paste(FirstName, LastName), TotalSaves), y = TotalSaves)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Goalkeepers by Total Saves Across All Matches", x = "Goalkeeper", y = "Total Saves") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave(filename = "plots/topGoalkeepersSaves.png", plot = plot_top_goalkeepers, width = 10, height = 6)


# Aggregate total goals against for each goalkeeper across all matches
total_goals_against <- goalkeeperData %>%
  group_by(FirstName, LastName) %>%
  summarise(TotalGoalsAgainst = sum(GA))

# Sort the data to get the top goalkeepers by total goals against
top_goalkeepers_goals_against <- total_goals_against %>%
  arrange(desc(TotalGoalsAgainst)) %>%
  head(10)

# Print the top goalkeepers by total goals against
cat("\nTop 10 Goalkeepers by Total Goals Against Across All Matches:\n")
print(top_goalkeepers_goals_against)

# Create a bar chart for the top goalkeepers by total goals against
plot_top_goalkeepers_goals_against <- ggplot(top_goalkeepers_goals_against, aes(x = reorder(paste(FirstName, LastName), TotalGoalsAgainst), y = TotalGoalsAgainst)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Goalkeepers by Total Goals Against Across All Matches", x = "Goalkeeper", y = "Total Goals Against") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave(filename = "plots/topGoalkeepersGoalsAgainst.png", plot = plot_top_goalkeepers_goals_against, width = 10, height = 6)
