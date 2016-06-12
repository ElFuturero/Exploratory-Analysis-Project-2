# This is the script to create the fourth plot for Project 2 of
# Exploratory Data Analysis in Coursera
# Student: Hector Meza Delgado
# Date: June 11, 2016

# First we start by downloading the files, unzipping them, and reading the contents
# into the variables NEI and SCC. We will do that by sourcing a
# script that I have prepared called "Project2Setup.R"
# It checks whether the object NEI exists in our workspace, otherwise
# loads it up

if(!exists("NEI")){
  source("Project2Setup.R")
}

# Let's use the dplyr and ggplot2 libraries

library(dplyr)
library(ggplot2)

# Preliminary examination of the SCC dataframe shows that motor vehicles
# are categorized as either "highway" or "off-highway" under the "SCC.Level.Two"
# column. We'll use the grepl function to find those codes relevant to us.

motorCodes <- SCC[grepl("highway",SCC$SCC.Level.Two, ignore.case = TRUE), "SCC"]

# Let's turn them into character type in order to match the NEI dataframe

motorCodes <- as.character(motorCodes)

# Now let's subset based on these codes. We will scale the emissions by log10
# as preliminary examination showed those of Los Angeles were higher by a factor of approx 10.

motorEms <- tbl_df(NEI) %>%   # this makes it into an easily readable form
  filter(SCC %in% motorCodes) %>%   # this selects only the rows for the motorCodes
  select(fips, Emissions, year) %>%   # this selects only the relevant columns
  filter(fips=="24510" | fips =="06037" ) %>%   # this selects only for the cities we need   
  mutate(city = ifelse(fips=="24510","Baltimore","Los Angeles")) %>% 
  group_by(year, city) %>%
  summarize(total = log10(sum(Emissions, na.rm= TRUE))) # we'll scale the emissions with log10

# Now let's graph. First let's set the device that we want.

png("plot6.png", width = 480, height = 480)

# Now we will use the qplot function from ggplot2 in order to make our graph

qplot(
  year,
  total,
  data = motorEms,
  geom = c("point", "line"),
  colour = city,   # this is just to make it a little prettier
  facets = .~city,   # this creates a little panel for each type
  main = "Total PM2.5 Emissions from Motor Vehicle Sources\n(1999-2008)",
  xlab = "Year",
  ylab = "Log10 of Total PM2.5 Emissions (log10(10^5 tons))"
) + theme(legend.position="none")   # turns off the legend

# Now finally let's turn off the device

dev.off()

# As we can see from the plot, Baltimore has seen a greater change with decreases in
# motor vehicle emissions over time, as compared to Los Angeles, which has consistently
# stayed much higher.