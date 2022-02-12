#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander [CHANGE THIS TO YOUR NAME!!!!]
# Data: 3 January 2021
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
# Use R Projects, not setwd().
install.packages("tidyverse")
install.packages("opendatatoronto")
install.packages("usethis")
install.packages("knitr")

library(knitr)
library(tidyverse)
library(opendatatoronto)

#### Data download ####
# From https://open.toronto.ca/dataset/fatal-and-non-fatal-suspected-opioid-overdoses-in-the-shelter-system/

library(opendatatoronto)
library(dplyr)


# get all resources for this package
resources <- list_package_resources("0d1fb545-d1b2-4e0a-b87f-d8a1835e5d85")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
drug_data <- filter(resources, row_number()==1) %>% get_resource()
drug_data

write_csv(drug_data, "inputs/data/overdoesdata.csv")
write_csv(drug_data, "verdoesdat.csv")
read.csv("verdoesdat.csv")
#changing dta that is used in graph 
overdoesdata <- read.csv("inputs/data/overdoesdata.csv")
overdoesdata <- read.csv("verdoesdat.csv")
overdoesdata$year = paste(overdoesdata$year, overdoesdata$year_stage)
g = as.numeric(overdoesdata$fatal_overdoses_incident)
g
r <- is.na(g)
g[r] = 0
overdoesdata$fatal_overdoses_incident = g
ind <- (which(r == T, arr.ind=TRUE))


overdoesdata <- read.csv("verdoesdat.csv")
overdoesdata$year = paste(overdoesdata$year, overdoesdata$year_stage)
g = as.numeric(overdoesdata$fatal_overdoses_incident)
g
r <- is.na(g)
g[r] = 0
overdoesdata$fatal_overdoses_incident = g
write_csv(overdoesdata, "overdoesdata0.csv")


#mutate(fatal_overdoses_incident = as.numeric(fatal_overdoses_incident))|>
#mutate((fatal_overdoses_incident[which(is.na(as.numeric(fatal_overdoses_incident)) == T, arr.ind=TRUE)])|>
        # mutate(fatal_overdoses_incident[which(is.na(as.numeric(fatal_overdoses_incident)) == T, arr.ind=TRUE)] = .5)
       #fatal_overdoses_incident[which(is.na(as.numeric(fatal_overdoses_incident)) == T, arr.ind=TRUE)] = .5

overdoes_clean <- 
  drug_data |>
  clean_names() |>
  #mutate(year_stage=paste(year, year_stage)) |>
  select(year_stage, year, id, suspected_non_fatal_overdoses_incidents) 

write_csv(overdoes_clean, "inputs/data/overdoesdataclean.csv")
 
write.csv(overdoes_clean, file = 'cleaned_ overdoes_clean')

#create table of overdoes per year 

over <- read_csv("inputs/data/overdoesdataclean.csv",
  show_col_types = FALSE)
over <- read.csv("verdoesdat.csv")

(which(over == "Total", arr.ind=TRUE))
r <- (which(over == "Total", arr.ind=TRUE))
r2 <- r[,1]
over2 <- over[-r2,]


over2 |>
  group_by(year) |> 
  summarize(not_fatal_overdos = mean(suspected_non_fatal_overdoses_incidents)) |>
  kable(caption = "Non-Fatal Suspected Opioid Overdoses Since 2018 in The Shelter System",
        col.names = c("Year", "Average quarterly number of Non-Fatal Overdoses"),
        digits = 0,
        booktabs = TRUE,
        linesep = ""
        )
        

#create table of verdoes per quarter
#dont have 2021 as doesn have Q4 info 

over2 |>
  filter(year <= '2020') |>
  group_by(year_stage) |> # We want to know the occupancy by month
  summarize(not_fatal_overdos = mean(suspected_non_fatal_overdoses_incidents))
  kable()
            


 
# make graph 
  over2 |> 
    ggplot(aes(x = year)) + # aes abbreviates aesthetics and enables us 
    # to specify the x axis variable
    geom_histogram(stat = 'count')
  #(x <- as.numeric(overdoesdata$fatal_overdoses_incident[c(5, 6, 10, 13:19)])
  #overdoesdata$fatal_overdoses_incident[c(5, 6, 10, 13:19)] = x
  
  
  #t = (which(overdoesdata == "< 5", arr.ind=TRUE))
 # y = t[,1]
  #overdoesdata$fatal_overdoses_incident[y] = 0 )
  
# We re interested in comparing how thenumber over overoses compares on a yearly 
  #parameter compared to a quartly 

   
overdoesdata$fatal_overdoses_incident[12] = "< 5"


overdoesdata |>
    ggplot(aes(x = suspected_non_fatal_overdoses_incidents, y = fatal_overdoses_incident,
               color = year)) +
    geom_point(alpha=.8) +
  labs(x = "Non-Fatal Suspected Opioid Overdoses ",
       y = 'Fatal Opioid Overdose Incident')
  
  


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
 
 
 marriagelicence_clean <- 
   love |>
   clean_names() |>
   select(time_period, id, marriage_licenses) |>
   mutate(time_period = as_date(time_period))
   #> filter(occupancy_date >= as_date("2021-07-01"))

 
 
 
 
 
 
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



         