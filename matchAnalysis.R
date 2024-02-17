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
