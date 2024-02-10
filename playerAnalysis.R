# Load the readxl package
library(readxl)
library(tidyverse)
library(tidytext)
library(ggplot2)

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

# Perform sentiment analysis
player_sentiment <- playerData %>%
  mutate(sentiment = ifelse(G > 0 | A > 0, "Positive", "Neutral"))

# Display summary of sentiment
cat("\nSummary of Sentiment Analysis:\n")
print(summary(player_sentiment$sentiment))

# Aggregate total goals for each player across all seasons
total_goals <- playerData %>%
  group_by(FirstName, LastName) %>%
  summarise(TotalGoals = sum(G))

# Sort the data to get the top 10 players by total goals
top_10_goals <- total_goals %>%
  arrange(desc(TotalGoals)) %>%
  head(10)

# Print the top 10 players by total goals
cat("\nTop 10 Players by Total Goals Across All Seasons:\n")
print(top_10_goals)

# Create a bar chart for the top 10 players by total goals
ggplot(top_10_goals, aes(x = reorder(paste(FirstName, LastName), TotalGoals), y = TotalGoals)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Players by Total Goals Across All Seasons (17/18-22/23)", x = "Player", y = "Total Goals") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
