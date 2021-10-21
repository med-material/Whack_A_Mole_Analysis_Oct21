library(gsheet)
library(tidyverse)
source("utils/loadrawdata.R")

options("digits.secs"=6)
# Load data from directories
D <- LoadFromDirectory("data")
A <- LoadFromDirectory("arduinoLog")

save(D, file = 'data_whack_raw.rda', compress=TRUE)
#load('data_whack_raw.rda')

# Load data from Google Sheets

#############
# Format D
#############
D <- D %>% rename(Condition = i2, Participant = i1)

D <- D %>% mutate(Participant = as.numeric(Participant))

D = D %>% mutate(Timestamp = as.POSIXct(Timestamp, format = "%Y-%m-%d %H:%M:%OS"),
                 Framecount = as.integer(Framecount)) %>%
  arrange(Timestamp)

#############
# Save to RDA
#############
# Split into 4 

save(D, file ='data_whack1.rda', compress=TRUE)
