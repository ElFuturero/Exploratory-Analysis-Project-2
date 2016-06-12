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

coalCodes <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE), "SCC"]

# They are currently factors but we'll transform them into characters in order
# to match our NEI dataframe

coalCodes <- as.character(coalCodes)

# Now we'll create a subset of NEI based on our coalCodes

coalEms <- subset(NEI, SCC %in% coalCodes)

# Now we'll sum the totals by year using the tapply function and reassign it
# to the variable. We'll scale them by 1000 to make the numbers more reasonable.
# The units are in 10^8 tons

coalEms <- with(coalEms, tapply(Emissions, year, sum, na.rm = TRUE))
coalEms <- coalEms/1000

# Now let's graph. First let's set the device that we want

png("plot4.png", width = 480, height = 480)

plot(
  names(coalEms),  # these are the years as created by the tapply function
  coalEms,       # our totals for emmissions in hundred millions of tons
  xaxp = c(1999, 2008, 9),   # our tick marks on the x-axis
  col = "red",    # the color of the plotted points
  pch = 19,        # the full color symbol
  main = "Total Coal Combustion-Related Emissions of PM2.5 in the US\n(1999-2008)",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (10^8 tons)"
)

# Let's connect the dots with lines for the sake of making it pretty

lines(
  names(coalEms),
  coalEms,
  col = "blue",
  lwd = 2
)

# Now finally let's turn off the device

dev.off()

# As we can see from the graph, emissions stayed relatively the same from 1999-2005
# dropping slightly in 2002 then increasing in 2005. However by 2008, the coal
# combustion-related emissions had dropped sharply.
