# UNDP-style R Data Pipeline Demo
# Author: Dereje Deressa

library(WDI)
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

countries <- c("ALB", "SRB", "GEO", "ARM", "KAZ", "UZB")

indicators <- c(
  gdp_per_capita = "NY.GDP.PCAP.CD",
  unemployment = "SL.UEM.TOTL.ZS"
)

raw_data <- WDI(
  country = countries,
  indicator = indicators,
  start = 2015,
  end = 2024
)

clean_data <- raw_data %>%
  select(country, iso2c, year, gdp_per_capita, unemployment)

write_csv(clean_data, "clean_data.csv")

gdp_plot <- clean_data %>%
  ggplot(aes(x = year, y = gdp_per_capita, color = country)) +
  geom_line() +
  theme_minimal()

ggsave("gdp_plot.png", plot = gdp_plot)

print(head(clean_data))
