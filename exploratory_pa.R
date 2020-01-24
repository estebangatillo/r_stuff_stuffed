# created by Steven Murschel @ 
# PI - Dr. Vivek Shandas
# Canopy Continuum Project, USFS
# 2020-01-23
# exploratory data analysis


if (!require(pacman)) {
  install.packages("pacman")
  library(pacman)
}

p_load(rgdal
       ,plyr
       ,dplyr
       ,magrittr
       ,gdalUtils
       ,raster
       ,sp
       ,sf
       ,rgeos
       ,leaflet
       ,parallel
       ,snow
       ,ggplot2
       ,rts
       ,RPostgres
       ,ggmap
       ,gridExtra
       ,skimr)

setwd("C:/cc/source_appendix")
source("./functions.R")


# load RDS file
sac_data <- readRDS("D:/SAC201819.RDS")

# take some looks
head(sac_data)
summary(sac_data)







