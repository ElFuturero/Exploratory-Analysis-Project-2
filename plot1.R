# This is the script to create the first plot for Project 2 of
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

# Now let's calculate total emissions by summing the emmissions
# for each of the years using the tapply function

totalEms <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))

# We'll scale the totals by dividing them by 1000 since they are very large.
# According to the EPA, the original units are in hundred thousands of tons (x10^5).
# The new units will be in hundred million of tons (x10^8)

totalEms <- totalEms/1000

# Now let's graph. First let's set the device that we want

png("plot1.png", width = 480, height = 480)

plot(
  names(totalEms),  # these are the years as created by the tapply function
  totalEms,       # our totals for emmissions in hundred millions of tons
  xaxp = c(1999, 2008, 9),   # our tick marks on the x-axis
  col = "red",    # the color of the plotted points
  pch = 19,        # the full color symbol
  main = "Total Emissions of PM2.5 in the US\n(1999-2008)",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (10^8 tons)"
)

# Let's connect the dots with lines for the sake of making it pretty

lines(
  names(totalEms),
  totalEms,
  col = "blue",
  lwd = 2
)

# Now finally let's turn off the device

dev.off()

# Finally we have our answer: as we can see from the plot,
# total emissions have decreased from 1999 to 2008