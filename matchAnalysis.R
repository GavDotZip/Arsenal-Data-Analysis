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
  
  # Display summary of match data
  cat("\nSummary of Players Data:\n")
  print(summary(matchData))
  
} else {
  cat("Error: Failed to load data from one or more files.\n")
}

# Count the number of games played per season
games_per_season <- matchData %>%
  group_by(Season) %>%
  summarise(Num_Games = n())

# Create a pie chart
ggplot(games_per_season, aes(x = "", y = Num_Games, fill = Season)) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) +
  labs(title = "Games Played per Season", fill = "Season") +
  theme_void() +
  theme(legend.position = "right")

# Save the pie chart to the 'plots' folder
ggsave("plots/games_per_season_pie_chart.png", plot = games_per_season)

# Calculate average attendance per season
avg_attendance_per_season <- matchData %>%
  group_by(Season) %>%
  summarise(Avg_Attendance = mean(Attendance, na.rm = TRUE))

# Create a line chart
line_chart <- ggplot(avg_attendance_per_season, aes(x = Season, y = Avg_Attendance)) +
  geom_line() +
  geom_point() +
  labs(title = "Average Attendance per Season", x = "Season", y = "Average Attendance")

# Save the line chart to the 'plots' folder
ggsave("plots/avg_attendance_per_season_line_chart.png", plot = line_chart)

# Count the number of matches played against each opponent
matches_against_opponent <- matchData %>%
  group_by(Opponent) %>%
  summarise(Num_Matches = n()) %>%
  arrange(desc(Num_Matches)) %>%
  top_n(10) # Select top 10 opponents with most matches

# Create a bar chart
bar_chart <- ggplot(matches_against_opponent, aes(x = fct_reorder(Opponent, Num_Matches), y = Num_Matches)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 Opponents", x = "Opponent", y = "Number of Matches") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Save the bar chart to the 'plots' folder
ggsave("plots/top_10_opponents_bar_chart.png", plot = bar_chart)

# Count the number of matches officiated by each referee
referee_games <- matchData %>%
  group_by(Referee) %>%
  summarise(Num_Games = n()) %>%
  arrange(desc(Num_Games)) %>%
  top_n(5) # Select top 5 referees with most games

# Create a bar chart
bar_chart_referee <- ggplot(referee_games, aes(x = fct_reorder(Referee, Num_Games), y = Num_Games)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 5 Referees by Number of Games", x = "Referee", y = "Number of Games") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Save the bar chart to the 'plots' folder
ggsave("plots/top_5_referees_bar_chart.png", plot = bar_chart_referee)

# Create a stacked bar chart per season
stacked_bar_chart <- matchData %>%
  group_by(Season) %>%
  summarise(Arsenal_Goals = sum(ArsenalScore),
            Opponent_Goals = sum(OpponentScore)) %>%
  pivot_longer(cols = c(Arsenal_Goals, Opponent_Goals),
               names_to = "Team", values_to = "Goals") %>%
  ggplot(aes(x = Season, y = Goals, fill = Team)) +
  geom_bar(stat = "identity") +
  labs(title = "Goals Scored by Arsenal vs Opponent per Season",
       x = "Season", y = "Goals") +
  scale_fill_manual(values = c("Arsenal_Goals" = "red", "Opponent_Goals" = "blue"),
                    name = "Team") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the stacked bar chart to the 'plots' folder
ggsave("plots/stacked_bar_chart_goals_per_season.png", plot = stacked_bar_chart)

# Create a stacked bar chart per season
stacked_bar_chart <- matchData %>%
  mutate(Result = ifelse(ArsenalScore > OpponentScore, "Win", 
                         ifelse(ArsenalScore == OpponentScore, "Draw", "Loss")),
         Result = factor(Result, levels = c("Win", "Draw", "Loss"))) %>%
  group_by(Season, HoAw, Result) %>%
  summarise(Count = n()) %>%
  ggplot(aes(x = Season, y = Count, fill = Result)) +
  geom_bar(stat = "identity", position = "stack") +
  facet_wrap(~HoAw, scales = "free", nrow = 2) +
  labs(title = "Outcome of Arsenal Matches per Season",
       x = "Season", y = "Count", fill = "Result") +
  theme_minimal() +
  theme(legend.position = "right")

# Save the stacked bar chart to the 'plots' folder
ggsave("plots/stacked_bar_chart_outcome_per_season.png", plot = stacked_bar_chart)
