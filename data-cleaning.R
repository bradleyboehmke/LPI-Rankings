library(gdata)
library(dplyr)
library(magrittr)
library(stringr)

# import LPI raw data
# excluded 2007 because of different variables tracked
url <- "http://lpi.worldbank.org/sites/default/files/International_LPI_from_2007_to_2016.xlsx"
lpi_raw_2010 <- read.xls(url, sheet = 3) %>% mutate(Year = 2010)
lpi_raw_2012 <- read.xls(url, sheet = 2) %>% mutate(Year = 2012)
lpi_raw_2014 <- read.xls(url, sheet = 1) %>% mutate(Year = 2014)
lpi_raw_2016 <- read.xls(url, sheet = 5) %>% mutate(Year = 2016)

rm(url)

# tidy and combine
raw_files <- ls()
lpi <- data.frame(NULL)

for(i in raw_files){
        
        j <- get(i)
        names(j)[2] <- "Code"
        
        j <- j %>%
                .[-1, ] %>%
                select(-contains("x.")) %>%
                set_colnames(c("Country", "Code", "Overall LPI Score", "Overall LPI Rank",
                               "Customs", "Infrastructure", "International Shipments", 
                               "Logistics Quality & Competence", "Tracking & Tracing",
                               "Timeliness", "Year"))
        
        lpi <- rbind(lpi, j)
}

rm(raw_files, i, j, lpi_raw_2010, lpi_raw_2012, lpi_raw_2014, lpi_raw_2016)


# clean up non-UTF-8 characters
lpi$Country <- as.character(lpi$Country)

#str_detect(lpi$Country, "voire") %>% which(.)
lpi$Country[c(109, 238, 389, 565)] <- "Cote d Ivoire"

#str_detect(lpi$Country, "Tom") %>% which(.)
lpi$Country[c(269, 394, 603)] <- "Sco Tomi and Principe"

write.csv(lpi, "data/lpi.csv", row.names = FALSE)
saveRDS(lpi, file = "data/lpi.rds")
