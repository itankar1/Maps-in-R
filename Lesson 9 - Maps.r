# Import Packages

install.packages("maps")
install.packages("mapproj")

#Import Library Read

library(readr)
library(tidyverse)
library(maps)
library(mapproj)

# Import Data

us_states<- map_data("state")

# Plot the map

m1 <- ggplot(data=us_states, aes(x=long, y=lat, group=region)) +
  geom_polygon(fill="white", color="black", linewidth=0.1) +
  theme_void()

# Plot the map with Albers projection

m2 <- m1 + coord_map("albers", lat0=39, lat1=45)

# Plot the map with Georgia

ga <- subset(us_states, region %in% c("georgia"))

# Plot the map with Georgia

m3 <- ggplot(data=ga, aes(x=long, y=lat, group=region)) +
  geom_polygon(fill="white", color="black", linewidth=0.1) +
  theme_void()

# Overlay Data on the Map

election <- read.csv("us_election_results_2016.csv")

# Merge election with us_states

# Capitalize the state names in us_states

us_states <- rename(us_states, state=region)

library(tools)

us_states$state <- toTitleCase(us_states$state)

# Merge the data

us_states_merged <- merge(us_states, election, by="state")

# Plot the map

m4 <- ggplot(data=us_states_merged, aes(x=long, y=lat, group=state, fill=winner)) +
  geom_polygon(color="black", linewidth=0.1) +
  theme_void() +
coord_map("albers", lat0=39, lat1=45)

# Change Color

m5 <- m4 + scale_fill_manual(values=c("blue", "red"), name="Winner", labels=c("Trump","Clinton"))

# Change Legend Position

m6 <- m5 + theme(legend.position="bottom")


# Plot pct_trump : Continuous Variable 

m7 <- ggplot(data=us_states_merged, aes(x=long, y=lat, group=state, fill=pct_trump)) +
  geom_polygon(color="black", linewidth=0.1) +
  theme_void() +
  coord_map("albers", lat0=39, lat1=45) +
  scale_fill_gradient(low="blue", high="red", name="Trump %")

# Change Label Name

m8 <- m7 + labs(fill=" Percentage Trump" )


