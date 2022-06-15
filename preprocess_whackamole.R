library(gsheet)
library(tidyverse)
source("utils/loadrawdata.R")

("digits.secs"=6)
# Load data from directories
#############
# Load D 
#############
load('data_whack_raw.rda')


#############
# load A | This is for the arduino logger 
#############
A <- LoadFromDirectory("arduinoLog",  event = NULL, meta=NULL, sample ="log")

save(D, file = 'data_whack_raw.rda', compress=TRUE)


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
# Format A | This is for thr arduino logger 
#############
A <- A %>% rename(Participant = i1)
A <- A %>% mutate(Participant = as.numeric(Participant)) 
  
A <- subset(A, select= -c(i0,i2,i3,i4,i5,i6,i7,i8,i9))

#############
# Save to RDA
#############
# Split into 4 

save(D, file ='data_whack1.rda', compress=TRUE)
save(A, file ='data_arduino.rda', compress=TRUE)
