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

# First we need to subset those sources related to coal combustion.
# Preliminary examination of the SCC dataframe has told us that we need to look
# for "coal" in the EI.Sector column. We'll create a character vector including
# the SCC codes for this subset. We'll use the grepl function to locate these.

coalCodes <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE)]

# They are currently factors but we'll transform them into characters in order
# to match our NEI dataframe

coalCodes <- as.character(coalCodes)

# Now we'll create a subset of NEI based on our coalCodes

coalEms <- subset(NEI, SCC %in% coalCodes)