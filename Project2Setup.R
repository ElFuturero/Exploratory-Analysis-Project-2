# This file downloads and unzips any necessary files for analysis for
# the second project of the Exploratory Data Analysis course
# from Coursera
# Student: Hector Meza Delgado

# First we want to create a data directory if one hasn't been created

if(!file.exists("data")){
  dir.create("data")
}

# Now we want to download and decompress the data if we haven't done so

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileDest <- "./data/project2data.zip"

if (!file.exists(fileDest)){
  download.file(fileURL, fileDest, method = "curl")
  # Now let's unzip the file contents
  unzip(fileDest, exdir = "./data" )
}

# Now let's load our data into two data frames
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")