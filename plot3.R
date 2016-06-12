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

# First let's subset the rows relevant to Baltimore, MD (fips == "24510") and for
# each of the sources and store them in different variables

baltPoint <- subset(NEI, fips == "24510" & type == "POINT")
baltNP <- subset(NEI, fips == "24510" & type == "NONPOINT")
baltRoad <- subset(NEI, fips == "24510" & type == "ON-ROAD")
baltNR <- subset(NEI, fips == "24510" & type == "NON-ROAD")

