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







# Edit code to fix the parsing error 
desserts <- read_csv("desserts.csv",
                     col_types = cols(
                       uk_airdate = col_date(format = "%d %B %Y"),
                       technical = col_number()
                     ),
                     na = c("", "NA", "N/A")
)

# View parsing problems
problems(desserts)











# Cast result a factor
desserts <- read_csv("desserts.csv", 
                     na = c("", "NA", "N/A"),
                     col_types = cols(
                       uk_airdate = col_date(format = "%d %B %Y"),
                       technical = col_number(),                       
                       result = col_factor(levels = NULL)
                     )
)

# Glimpse to view
glimpse(desserts)














# Count rows grouping by nut variable
desserts %>% 
  count(nut, sort = TRUE)

# Edit code to recode "no nut" as missing
desserts_2 <- desserts %>% 
  mutate(nut = recode(nut, "filbert" = "hazelnut", 
                      "no nut" =  NA_character_))

# Count rows again 
desserts_2 %>% 
  count(nut, sort = TRUE)


















# Edit to recode tech_win as factor
desserts <- desserts %>% 
  mutate(tech_win = recode_factor(technical, `1` = 1,
                                  .default = 0))

# Count to compare values                      
desserts %>% 
  count(technical == 1, tech_win)








###### Couldn't do this:::::


#For series with 10 episodes, which showed the most growth in viewers from the premiere to the finale? Which showed the least?












# Recode channel as factor: bbc (1) or not (0)
ratings <- ratings %>% 
  mutate(bbc = recode_factor(channel, 
                             "Channel 4" = 0,
                             .default = 1))

# Select to look at variables to plot next
ratings %>% 
  select(series, channel, bbc, viewer_growth)

# Make a filled bar chart
ggplot(ratings, aes(x = series, y = viewer_growth, fill = bbc)) +
  geom_col()






tidy_ratings <- ratings %>%
    # Gather and convert episode to factor
	gather(key = "episode", value = "viewers_7day", -series, 
           factor_key = TRUE, na.rm = TRUE) %>%
	# Sort in ascending order by series and episode
    arrange(series, episode) %>% 
	# Create new variable using row_number()
    mutate(episode_count = row_number())

# Plot viewers by episode and series
ggplot(tidy_ratings, aes(x = episode_count, 
                y = viewers_7day, 
                fill = series)) + geom_col()













# Move channel to front and drop 7-/28-day episode ratings
ratings %>% 
  select(channel,  everything(), -ends_with("day"))










# Glimpse to see variable names
glimpse(messy_ratings)

# Load janitor
library(janitor)

# Reformat to snake case
ratings <- messy_ratings %>%  
  clean_names()

# Glimpse cleaned names
glimpse(ratings)











# Adapt code to also rename 7-day viewer data
viewers_7day <- ratings %>% 
  select(series, viewers_7day_ = ends_with("7day"))

# Glimpse
glimpse(viewers_7day)











# Adapt code to keep original order
viewers_7day <- ratings %>% 
  select(everything(), viewers_7day_ = ends_with("7day"), 
         -ends_with("28day"))

# Glimpse
glimpse(viewers_7day)













############################# CHAPTER 3 ################################################




# Plot of episode 1 viewers by series
ggplot(ratings, aes(x = series, y = e1)) +
    geom_col()



# Adapt code to plot episode 2 viewers by series
ggplot(ratings, aes(x = series, y = e2)) +
    geom_col()










tidy_ratings <- ratings %>%
    # Gather and convert episode to factor
	gather(key = "episode", value = "viewers_7day", -series, 
           factor_key = TRUE, na.rm = TRUE)









