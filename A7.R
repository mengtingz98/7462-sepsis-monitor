library(tidyverse)
library(data.table) ## For the fread function
library(lubridate)

source("sepsis_monitor_functions.R")

df <- initializePatients()

library(googledrive)

# We have to write the file to disk first, then upload it
#df %>% write_csv("sepsis_report_temp.csv")

# Uploading happens here
#drive_put(media = "sepsis_report_temp.csv",  
          #path = "https://drive.google.com/drive/folders/1ml6Uz3Vo13x5Zd9UEWWghAsVLgldOqV6",
          #name = "sepsis_report.csv")

#R script that reads in the current sepsis_report.csv file from Google Drive, 
#update
file_link <- "https://drive.google.com/file/d/19JJd6SLHTHZZ8ojisx0bpKjxQTAF7aOj/view"
sepsis <- drive_read_string(file_link) %>%
  read_csv()

sepsis

#updates it using the updatePatients function, 

sepsis_v2 <- updatePatients(sepsis, 10)

#and writes the updated file back to Google Drive (FYI, you can use the drive_put command above to replace an existing file with a new version).
sepsis_v2 %>% write_csv("sepsis_v2.csv")

drive_put(media = "sepsis_v2.csv",  
          path = "https://drive.google.com/drive/folders/1ml6Uz3Vo13x5Zd9UEWWghAsVLgldOqV6",
          name = "sepsis_report.csv")
