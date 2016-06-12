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
# According to the EPA, the units are in hundred thousands of tons (x10^5).

baltTotals <- with(baltSet, tapply(Emissions, year, sum, na.rm = TRUE))

# Now let's graph. First let's set the device that we want

png("plot2.png", width = 480, height = 480)

plot(
  names(baltTotals),  # these are the years as created by the tapply function
  baltTotals,       # our totals for emmissions in hundred millions of tons
  xaxp = c(1999, 2008, 9),   # our tick marks on the x-axis
  col = "red",    # the color of the plotted points
  pch = 19,        # the full color symbol
  main = "Total Emissions of PM2.5 in Baltimore, MD\n(1999-2008)",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (10^5 tons)"
)

# Let's connect the dots with lines for the sake of making it pretty

lines(
  names(baltTotals),
  baltTotals,
  col = "blue",
  lwd = 2
)

# Now finally let's turn off the device

dev.off()

# As we can see from the graph emissions go down from 1999 to 2002 but then increase
# again in 2005, and finally decrease in 2008. Overall there is a net reduction from
# 1999 to 2008 of total emissions