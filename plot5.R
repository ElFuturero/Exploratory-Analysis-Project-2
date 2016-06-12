# This is the script to create the fifth plot for Project 2 of
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

motorCodes <- SCC[grepl("highway",SCC$SCC.Level.Two, ignore.case = TRUE), "SCC"]

# Let's turn them into character type in order to match the NEI dataframe

motorCodes <- as.character(motorCodes)

# Now let's subset based on these codes

motorEms <- subset(NEI, SCC %in% motorCodes)

# Now let's subset based on those in Baltimore

baltMotors <- subset(motorEms, fips == "24510")

# Now let's total them by  year using tapply
# The units are in 10^5 tons

baltMotors <- with(baltMotors, tapply(Emissions, year, sum, na.rm = TRUE))

# Now let's graph. First let's set the device that we want

png("plot5.png", width = 480, height = 480)

plot(
  names(baltMotors),  # these are the years as created by the tapply function
  baltMotors,       # our totals for emmissions in hundred millions of tons
  xaxp = c(1999, 2008, 9),   # our tick marks on the x-axis
  col = "red",    # the color of the plotted points
  pch = 19,        # the full color symbol
  main = "Total Emissions of PM2.5 from Motor Vehicle Sources\nin Baltimore, MD (1999-2008)",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (10^5 tons)"
)

# Let's connect the dots with lines for the sake of making it pretty

lines(
  names(baltMotors),
  baltMotors,
  col = "blue",
  lwd = 2
)

# Now finally let's turn off the device

dev.off()

# As we can see emissions from motor vehicle sources have decreased in every year plotted
# from 1999 to 2008.
