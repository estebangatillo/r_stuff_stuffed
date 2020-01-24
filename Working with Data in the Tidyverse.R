#### Working with Data in the Tidyverse


##################CHAPTER 1  ###################


# Load readr
library(readr)

# Create bakeoff but skip first row
bakeoff <- read_csv("bakeoff.csv", skip = 1)

# Print bakeoff
bakeoff




# Load dplyr
library(dplyr)

# Filter rows where showstopper is UNKNOWN 
bakeoff %>% 
  filter(showstopper == "UNKNOWN")

# Edit to add list of missing values
bakeoff <- read_csv("bakeoff.csv", skip = 1,
                    na = c("", "NA", "UNKNOWN"))

# Filter rows where showstopper is NA 
bakeoff %>% filter(is.na(showstopper))








# Load skimr
library(skimr)

# Edit to filter, group by, and skim
bakeoff %>% 
  filter(!is.na(us_season)) %>% 
  group_by(us_season)  %>% 
  skim()









# Add second count by series
bakeoff %>% 
  count(series, episode) %>% 
  count(series)







# Count the number of rows by series and baker
bakers_by_series <- bakeoff %>% 
  count(series, baker)

# Print to view
bakers_by_series

# Count again by series
bakers_by_series %>% 
  count(series)

# Count again by baker
bakers_by_series %>% count(baker, sort = TRUE)








ggplot(bakeoff, aes(episode)) + 
  geom_bar() + 
  facet_wrap(~series)





##################################### CAHPTER 2 #####################################


# type casting - save time by organizing the data. Tame the dataframe. using the readr package.
# example: we have a number (year) but it has the word "years" in it. dplyr....missed a bunch...

# re-made a column to better organize the date of the episode.
# parse any variable type....





# Find format to parse uk_airdate 
parse_date("17 August 2010", format = "%d %B %Y")

# Edit to cast uk_airdate
desserts <- read_csv("desserts.csv", 
                     col_types = cols(
                       uk_airdate = col_date(format = "%d %B %Y")
                     )
)

# Arrange by descending uk_airdate
desserts %>% 
  arrange(desc(uk_airdate))













