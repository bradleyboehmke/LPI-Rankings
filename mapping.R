install.packages("googleVis")
library(googleVis)

lpi <- read_csv("data/lpi.csv")
lpi <- readRDS("data/lpi.rds")
# clean up non-UTF-8 characters
#str_detect(lpi$Country, "voire") %>% which(.)
lpi$Country[c(109, 238, 389, 565)] <- "Cote d Ivoire"

#str_detect(lpi$Country, "Tom") %>% which(.)
lpi$Country[c(269, 394, 603)] <- "Sco Tomi and Principe"


Geo <- gvisGeoChart(lpi, locationvar="Country", 
                 colorvar="Overall LPI Score",
                 options=list(width="1000px", height="500px"),
                 )
plot(Geo)


str(Geo)

Geo$html$chart

##########
# plotly #
##########
library(plotly)

l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g <- list(
        showframe = FALSE,
        showcoastlines = FALSE,
        projection = list(type = 'Mercator')
)

plot_ly(lpi, z = `Overall LPI Score`, text = Country, locations = Code, type = 'choropleth',
        color = `Overall LPI Score`, colors = 'Blues', marker = list(line = l),
        colorbar = list(title = 'LPI Score')) %>%
        layout(title = 'Global Logistics Performance Index',
               geo = g)



###########
# leaflet #
###########
library(leaflet)

m <- leaflet() %>%
        addTiles() %>%
        