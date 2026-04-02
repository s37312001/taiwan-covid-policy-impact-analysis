# Taiwan COVID-19 Policy Impact Analysis
# analysis.R
# Run from project root with:
# source("scripts/analysis.R")

options(stringsAsFactors = FALSE)

required_packages <- c(
  "tidyverse",
  "lubridate",
  "ggplot2",
  "gridExtra",
  "zoo"
)

install_if_missing <- function(pkgs) {
  missing <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]
  if (length(missing) > 0) {
    install.packages(missing, repos = "https://cloud.r-project.org")
  }
}

install_if_missing(required_packages)

library(tidyverse)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(zoo)

raw_dir <- "data/raw"
processed_dir <- "data/processed"
figures_dir <- "figures"

dir.create(processed_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figures_dir, recursive = TRUE, showWarnings = FALSE)

covid_path <- file.path(raw_dir, "owid-covid-data.csv")
face_path <- file.path(raw_dir, "face-covering-policies-covid.csv")
public_path <- file.path(raw_dir, "public-events-covid.csv")
home_path <- file.path(raw_dir, "stay-at-home-covid.csv")

required_files <- c(covid_path, face_path, public_path, home_path)
missing_files <- required_files[!file.exists(required_files)]

if (length(missing_files) > 0) {
  stop(
    paste(
      "Missing required files:",
      paste(missing_files, collapse = ", "),
      "\nPlease place them in data/raw/ before running this script."
    )
  )
}

prepare_policy_data <- function(file_path, value_col_name, country = "Taiwan", year_filter = 2021) {
  df <- read.csv(file_path, header = TRUE)
  df_clean <- df %>%
    mutate(Day = ymd(Day)) %>%
    filter(Entity == country, year(Day) == year_filter)

  candidate_cols <- setdiff(names(df_clean), c("Entity", "Code", "Day"))
  if (length(candidate_cols) == 0) {
    stop(paste("No policy column found in", file_path))
  }

  value_col <- candidate_cols[1]

  df_clean %>%
    select(Day, !!sym(value_col)) %>%
    rename(!!value_col_name := !!sym(value_col))
}

save_plot <- function(plot_obj, filename, width = 10, height = 5, dpi = 300) {
  ggsave(
    filename = file.path(figures_dir, filename),
    plot = plot_obj,
    width = width,
    height = height,
    dpi = dpi
  )
}

covid_raw <- read.csv(covid_path, header = TRUE)

covid_2021 <- covid_raw %>%
  mutate(date = ymd(date)) %>%
  filter(location == "Taiwan", year(date) == 2021) %>%
  select(location, date, new_cases) %>%
  rename(Day = date)

facial_coverings <- prepare_policy_data(face_path, "facial_coverings", country = "Taiwan", year_filter = 2021)
cancel_public_events <- prepare_policy_data(public_path, "cancel_public_events", country = "Taiwan", year_filter = 2021)
stay_home_requirements <- prepare_policy_data(home_path, "stay_home_requirements", country = "Taiwan", year_filter = 2021)

covid_data <- covid_2021 %>%
  left_join(facial_coverings, by = "Day") %>%
  left_join(cancel_public_events, by = "Day") %>%
  left_join(stay_home_requirements, by = "Day") %>%
  mutate(
    facial_coverings = replace_na(as.numeric(facial_coverings), 0),
    cancel_public_events = replace_na(as.numeric(cancel_public_events), 0),
    stay_home_requirements = replace_na(as.numeric(stay_home_requirements), 0),
    new_cases = replace_na(as.numeric(new_cases), 0),
    level_new_cases = cut(new_cases, breaks = 5, labels = 0:4, include.lowest = TRUE)
  )

write.csv(covid_data, file.path(processed_dir, "covid_policy_taiwan_2021.csv"), row.names = FALSE)

chi_face <- chisq.test(covid_data$level_new_cases, covid_data$facial_coverings, correct = FALSE)
chi_public <- chisq.test(covid_data$level_new_cases, covid_data$cancel_public_events, correct = FALSE)
chi_home <- chisq.test(covid_data$level_new_cases, covid_data$stay_home_requirements, correct = FALSE)

chi_results <- tibble(
  policy = c("facial_coverings", "cancel_public_events", "stay_home_requirements"),
  x_squared = c(unname(chi_face$statistic), unname(chi_public$statistic), unname(chi_home$statistic)),
  df = c(unname(chi_face$parameter), unname(chi_public$parameter), unname(chi_home$parameter)),
  p_value = c(chi_face$p.value, chi_public$p.value, chi_home$p.value)
)

write.csv(chi_results, file.path(processed_dir, "chi_square_results_2021.csv"), row.names = FALSE)

facial_plot <- ggplot(covid_data, aes(x = Day)) +
  geom_line(aes(y = new_cases / 100, color = "New Cases (hundred)")) +
  geom_line(aes(y = facial_coverings, color = "Levels of Facial Covering Policies")) +
  labs(x = NULL, y = NULL, title = "Levels of Facial Covering Policies in 2021", color = "Legend") +
  scale_color_manual(values = c("New Cases (hundred)" = "red", "Levels of Facial Covering Policies" = "blue")) +
  theme_minimal()

public_plot <- ggplot(covid_data, aes(x = Day)) +
  geom_line(aes(y = new_cases / 100, color = "New Cases (hundred)")) +
  geom_line(aes(y = cancel_public_events, color = "Levels of Public Event Cancellation")) +
  labs(x = NULL, y = NULL, title = "Levels of Public Event Cancellation in 2021", color = "Legend") +
  scale_color_manual(values = c("New Cases (hundred)" = "red", "Levels of Public Event Cancellation" = "green")) +
  theme_minimal()

home_plot <- ggplot(covid_data, aes(x = Day)) +
  geom_line(aes(y = new_cases / 100, color = "New Cases (hundred)")) +
  geom_line(aes(y = stay_home_requirements, color = "Levels of Stay at Home Requirement")) +
  labs(x = NULL, y = NULL, title = "Levels of Stay at Home Requirement in 2021", color = "Legend") +
  scale_color_manual(values = c("New Cases (hundred)" = "red", "Levels of Stay at Home Requirement" = "purple")) +
  theme_minimal()

save_plot(facial_plot, "face_covering_vs_new_cases.png")
save_plot(public_plot, "public_event_cancellation_vs_new_cases.png")
save_plot(home_plot, "stay_home_vs_new_cases.png")

combined_2021 <- grid.arrange(facial_plot, public_plot, home_plot, ncol = 1)
ggsave(filename = file.path(figures_dir, "combined_policy_plots_2021.png"), plot = combined_2021, width = 10, height = 14, dpi = 300)

covid_data_2022 <- covid_raw %>%
  mutate(date = ymd(date)) %>%
  filter(location == "Taiwan", year(date) == 2022) %>%
  select(location, date, people_vaccinated, total_cases, total_deaths) %>%
  arrange(date) %>%
  mutate(
    people_vaccinated = na.locf(people_vaccinated, na.rm = FALSE),
    total_cases = na.locf(total_cases, na.rm = FALSE),
    total_deaths = na.locf(total_deaths, na.rm = FALSE)
  )

if (is.na(covid_data_2022$people_vaccinated[1])) {
  covid_data_2022$people_vaccinated[1] <- 18712858
}

covid_data_2022 <- covid_data_2022 %>%
  mutate(mortality_rate = total_deaths / total_cases)

write.csv(covid_data_2022, file.path(processed_dir, "covid_metrics_taiwan_2022.csv"), row.names = FALSE)

people_vaccinated_bar <- ggplot(covid_data_2022, aes(date, people_vaccinated / 1000000)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  labs(x = NULL, y = "People vaccinated (million)", title = "People Vaccinated (million) in 2022 (cumulative)") +
  theme_minimal()

total_cases_bar <- ggplot(covid_data_2022, aes(date, total_cases / 1000000)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  labs(x = NULL, y = "Total cases (million)", title = "Total Cases (million) in 2022 (cumulative)") +
  theme_minimal()

total_deaths_bar <- ggplot(covid_data_2022, aes(date, total_deaths / 1000000)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(x = NULL, y = "Total deaths (million)", title = "Total Deaths (million) in 2022 (cumulative)") +
  theme_minimal()

mortality_plot <- ggplot(covid_data_2022, aes(date, mortality_rate)) +
  geom_line(color = "red") +
  labs(x = NULL, y = "Total Deaths / Total Cases", title = "Mortality Rate") +
  theme_minimal()

save_plot(people_vaccinated_bar, "people_vaccinated_2022.png")
save_plot(total_cases_bar, "total_cases_2022.png")
save_plot(total_deaths_bar, "total_deaths_2022.png")
save_plot(mortality_plot, "mortality_rate.png")

combined_2022 <- grid.arrange(people_vaccinated_bar, total_cases_bar, total_deaths_bar, ncol = 1)
ggsave(filename = file.path(figures_dir, "combined_2022_bars.png"), plot = combined_2022, width = 10, height = 12, dpi = 300)

cat("\n=== Analysis complete ===\n")
print(chi_results)
