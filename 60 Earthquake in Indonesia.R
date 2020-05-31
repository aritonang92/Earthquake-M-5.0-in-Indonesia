library(readxl)
library(tidyverse)
library(lubridate)
library(chron)
library(stringr)

#Import data
#Data berasal dari portal Data Terbuka BMKG (dalam ekstensi XML yang diubah menjadi .xlsx)
gempa <- read_excel("C://Users/LENOVO/Desktop/Gempa terkini.xlsx")

#Data cleaning
gempa$Kedalaman <- gsub(paste0("Km", collapse = "|"),"",gempa$Kedalaman) %>% trimws()
gempa$Magnitude <- gsub(paste0("SR", collapse = "|"),"",gempa$Magnitude) %>% trimws()
gempa$Jam <- gsub(paste0("WIB", collapse = "|"),"",gempa$Jam) %>% trimws
gempa$Tanggal <- str_replace_all(gempa$Tanggal, "-", " ") %>% dmy()
y <- chron(times = gempa$Jam)
gempa$Jam <- y
gempa$Lokasi <- word(gempa$Wilayah, -1)
gempa <- gempa[,-(c(5,6,9))] %>% mutate_at(c("Bujur","Lintang","Magnitude","Kedalaman"), as.numeric) %>%
  rename(`Jam (WIB)` = Jam)

library(ggplot2)
library(raster)

indonesia <- getData("GADM", country = "IDN", level = 0)
indonesia <- fortify(indonesia)

ggplot()+
  geom_map(data = indonesia, map = indonesia, aes(x=long,y=lat,map_id=id,group=group),
           fill=NA, colour="black") +
  geom_point(data = gempa, aes(x = Bujur, y = Lintang, colour = Magnitude), size = 6.5,
             alpha = 1, na.rm = TRUE) +
  scale_size(range=c(2,7))+ 
  labs(title= "The Latest 60 Earthquake Above M 5.0 in Indonesia (Magnitude is up 0.5 in range) - As May 30, 2020", subtitle = "*Raw data is extracted from BMKG official open portal",
       x = "Longitude", y = "Latitude") +  
  theme(title= element_text(hjust = 0.5, vjust = 1, face = c("bold")), axis.title = element_text(size = 17)) 
