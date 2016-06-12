# This is the script to create the second plot for Project 2 of
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

# First let's subset the rows relevant to Baltimore, MD (fips == "24510")

baltSet <- subset(NEI, fips == "24510")

# Now let's use tapply to get the totals by year

baltTotals <- with(baltSet, tapply(Emissions, year, sum, na.rm = TRUE))