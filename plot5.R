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

# Preliminary examination of the SCC dataframe shows that motor vehicles
# are categorized as either "highway" or "off-highway" under the "SCC.Level.Two"
# column. We'll use the grepl function to find those codes relevant to us.

