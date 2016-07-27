library(readr)

lpi <- read_csv("data/lpi.csv")

shinyServer(function(input, output) {
        
        output$trendPlot <- renderPlotly({
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
        })
})