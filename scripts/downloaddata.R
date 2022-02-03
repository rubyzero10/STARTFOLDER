#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander [CHANGE THIS TO YOUR NAME!!!!]
# Data: 3 January 2021
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
# Use R Projects, not setwd().
install.packages("tidyverse")
install.packages("opendatatoronto")
install.packages("usethis")

library(tidyverse)
library(opendatatoronto)

#### Data download ####
# From https://open.toronto.ca/dataset/fatal-and-non-fatal-suspected-opioid-overdoses-in-the-shelter-system/

library(opendatatoronto)
library(dplyr)

# get package
#package <- show_package("0d1fb545-d1b2-4e0a-b87f-d8a1835e5d85")
package

# get all resources for this package
resources <- list_package_resources("0d1fb545-d1b2-4e0a-b87f-d8a1835e5d85")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(resources, row_number()==1) %>% get_resource()
data
 overdoes <- resources %>% 
   get_resource()



#try anotger data 
 
 library(opendatatoronto)
 library(dplyr)
 
 # get package
 package2 <- show_package("e28bc818-43d5-43f7-b5d9-bdfb4eda5feb")
 package2
 
 # get all resources for this package
 resources2 <- list_package_resources("e28bc818-43d5-43f7-b5d9-bdfb4eda5feb")
 love <- resources2 %>% 
   get_resource()

 #save data 
 write_csv(love, "inputs/data/marriagelicense.csv")
 
 


# Read in the raw data. 
raw_data <- readr::read_csv("inputs/data/raw_data.csv"
                     )
# Just keep some variables that may be of interest (change 
# this depending on your interests)
names(raw_data)

reduced_data <- 
  raw_data %>% 
  select(first_col, 
         second_col)
rm(raw_data)
         

#### What's next? ####



         