# This is the script to create the third plot for Project 2 of
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

# Next we load up our libraries

library(dplyr)
library(ggplot2)

# We will use the dplyr library in order to create a nice ordered dataframe
# that is summarized by year and type

baltEms <- subset(NEI, fips == "24510") %>%
  tbl_df %>%
  select(Emissions, year, type) %>%
  group_by(year, type) %>%
  summarize(total = sum(Emissions, na.rm= TRUE))

# Now in order to graph, we will initialize our device

# Now let's graph. First let's set the device that we want

png("plot3.png", width = 480, height = 480)

# Now we will use the qplot function from ggplot2 in order to make our graph

qplot(
  year,
  total,
  data = baltEms,
  geom = c("point", "line"),
  colour = type,   # this is just to make it a little prettier
  facets = .~type,   # this creates a little panel for each type
  main = "Total PM2.5 Emissions by Source in Baltimore, MD\n(1999-2008)",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (10^5 tons)"
  ) + theme(legend.position="none")   # turns off the legend

# Now finally let's turn off the device

dev.off()

# Based on the graph all sources except POINT have had a net decrease from 1999-2008.
# POINT sources have increased, with a sharp spike on 2005, coming down to almost 1999
# levels by 2008