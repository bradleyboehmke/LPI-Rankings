# This script was used to test run the radar chart and to create code necessary
# for the table underneath the radar chart.  Yes, I know the table code is very
# inefficient!

library(radarchart)
library(dplyr)
library(tidyr)

######################
# create radar chart #
######################
# Example from mangothecat readme
labs <- c("Communicator", "Data Wrangler", "Programmer",
          "Technologist", "Modeller", "Visualizer")

scores <- list(
        "Rich" = c(9, 7, 4, 5, 3, 7),
        "Andy" = c(7, 6, 6, 2, 6, 9),
        "Aimee" = c(6, 5, 8, 4, 7, 6)
        )

chartJSRadar(scores = scores, labs = labs, maxScale = 10)


# filter country & year
country <- "Costa Rica"
year <- c(2010, 2012, 2014, 2016)

df <- lpi %>%
        filter(Country == country & Year %in% year) %>%
        select(-Code, -`Overall LPI Rank`, -Country) %>%
        gather(Label, Value, -Year) %>%
        spread(Year, Value)

chartJSRadar(df, maxScale = 5, showToolTipLabel = TRUE)


########################
# create ranking table #
########################
# information for the description text above the table
lpi %>%
        group_by(Country) %>%
        summarise(Overall = mean(`Overall LPI Score`, na.rm = TRUE)) %>%
        arrange(desc(Overall)) %>%
        mutate(Rank = seq(1, length(Country), by =1))


# creating the ranking table
rank_table <- lpi %>%
        group_by(Year) %>%
        mutate(`Overall LPI` = `Overall LPI Rank`) %>%
        arrange(desc(Customs)) %>%
        mutate(Customs = seq(1, length(Country))) %>%
        arrange(desc(Infrastructure)) %>%
        mutate(Infrastructure = seq(1, length(Country))) %>%
        arrange(desc(`International Shipments`)) %>%
        mutate(`International Shipments` = seq(1, length(Country))) %>%
        arrange(desc(`Logistics Quality & Competence`)) %>%
        mutate(`Logistics Quality & Competence` = seq(1, length(Country))) %>%
        arrange(desc(`Tracking & Tracing`)) %>%
        mutate(`Tracking & Tracing` = seq(1, length(Country))) %>%
        arrange(desc(Timeliness)) %>%
        mutate(Timeliness = seq(1, length(Country))) %>%
        select(-Code, -`Overall LPI Score`, -`Overall LPI Rank`) %>%
        gather(Metric, Score, -Country, -Year) %>%
        spread(Year, Score) %>%
        mutate(Metric = factor(.$Metric, levels = c("Overall LPI", "Customs", "Infrastructure",
                                                     "International Shipments", "Logistics Quality & Competence",
                                                     "Tracking & Tracing", "Timeliness"))) %>%
        arrange(Metric) %>%
        mutate(Avg = (`2010` + `2012` + `2014` + `2016`) / 4)