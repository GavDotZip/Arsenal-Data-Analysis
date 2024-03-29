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
plot_top_goals <- ggplot(top_10_goals, aes(x = reorder(paste(FirstName, LastName), TotalGoals), y = TotalGoals)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Players by Total Goals Across All Seasons (17/18-22/23)", x = "Player", y = "Total Goals") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave(filename = "plots/topGoalScorers.png", plot = plot_top_goals, width = 10, height = 6)


# Aggregate total passes for each player across all seasons
total_passes <- playerData %>%
  group_by(FirstName, LastName) %>%
  summarise(TotalPasses = sum(Passes))

# Sort the data to get the top 10 players by total passes
top_10_passes <- total_passes %>%
  arrange(desc(TotalPasses)) %>%
  head(10)

# Print the top 10 players by total passes
cat("\nTop 10 Players by Total Passes Across All Seasons:\n")
print(top_10_passes)

# Create a bar chart for the top 10 players by total passes
plot_top_passes <- ggplot(top_10_passes, aes(x = reorder(paste(FirstName, LastName), TotalPasses), y = TotalPasses)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Players by Total Passes Across All Seasons (17/18-22/23)", x = "Player", y = "Total Passes") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave(filename = "plots/topPassMakers.png", plot = plot_top_passes, width = 10, height = 6)


# Aggregate total minutes played for each player across all seasons
total_minutes_played <- playerData %>%
  group_by(FirstName, LastName) %>%
  summarise(TotalMinutesPlayed = sum(Min))

# Sort the data to get the top 10 players by total minutes played
top_10_minutes_played <- total_minutes_played %>%
  arrange(desc(TotalMinutesPlayed)) %>%
  head(10)

# Print the top 10 players by total minutes played
cat("\nTop 10 Players by Total Minutes Played Across All Seasons:\n")
print(top_10_minutes_played)

# Create a bar chart for the top 10 players by total minutes played
plot_top_minutes_played <- ggplot(top_10_minutes_played, aes(x = reorder(paste(FirstName, LastName), TotalMinutesPlayed), y = TotalMinutesPlayed)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Players by Total Minutes Played Across All Seasons", x = "Player", y = "Total Minutes Played") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave(filename = "plots/topMinutesPlayed.png", plot = plot_top_minutes_played, width = 10, height = 6)



# Aggregate total games as captain for each player across all seasons
total_captain_games <- playerData %>%
  filter(C == 1) %>%  # Filter rows where player is captain
  group_by(FirstName, LastName) %>%
  summarise(TotalCaptainGames = n())  # Count the number of rows for each player

# Sort the data to get the top 10 players by total games as captain
top_10_captains <- total_captain_games %>%
  arrange(desc(TotalCaptainGames)) %>%
  head(10)

# Print the top 10 players by total games as captain
cat("\nTop 10 Players by Total Games as Captain Across All Seasons:\n")
print(top_10_captains)

# Create a bar chart for the top 10 players by total games as captain
plot_top_captains <- ggplot(top_10_captains, aes(x = reorder(paste(FirstName, LastName), TotalCaptainGames), y = TotalCaptainGames)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Players by Total Games as Captain Across All Seasons", x = "Player", y = "Total Games as Captain") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave(filename = "plots/topCaptains.png", plot = plot_top_captains, width = 10, height = 6)


# Calculate time played to goals ratio for each player
playerData <- mutate(playerData, TimeToGoalsRatio = Min / G)

# Filter out infinite and NA values
playerData <- playerData[is.finite(playerData$TimeToGoalsRatio) & !is.na(playerData$TimeToGoalsRatio), ]

# Aggregate total time played to goals ratio for each player across all seasons
total_time_to_goals_ratio <- playerData %>%
  group_by(FirstName, LastName) %>%
  summarise(TotalTimeToGoalsRatio = sum(TimeToGoalsRatio))

# Sort the data to get the top 10 players by total time played to goals ratio
top_10_time_to_goals_ratio <- total_time_to_goals_ratio %>%
  arrange(TotalTimeToGoalsRatio) %>%
  head(10)

# Print the top 10 players by total time played to goals ratio
cat("\nTop 10 Players by Total Time Played to Goals Ratio Across All Seasons:\n")
print(top_10_time_to_goals_ratio)

# Create a stacked bar chart for the top 10 players by total time played to goals ratio
plot_top_time_to_goals_ratio <- ggplot(top_10_time_to_goals_ratio, aes(x = reorder(paste(FirstName, LastName), TotalTimeToGoalsRatio), y = TotalTimeToGoalsRatio, fill = "Total Time Played to Goals Ratio")) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 Players by Total Time Played to Goals Ratio Across All Seasons", x = "Player", y = "Total Time Played to Goals Ratio") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = "skyblue")

# Save the plot
ggsave(filename = "plots/topTimeToGoalsRatio.png", plot = plot_top_time_to_goals_ratio, width = 10, height = 6)

