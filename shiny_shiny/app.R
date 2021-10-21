library (shiny)
library (leaflet)
df <- adatb
megyek <- df$Megye
ui <- fluidPage (
    
    titlePanel ("shiny shiny"),
    
    sidebarLayout (
        
        sidebarPanel (
            selectizeInput("megye", "megye kiválasztása", megyek )
        ),
        
        mainPanel (
            plotOutput ("valamiPlot")
        )
        
    )
)


server <- function (input, output) {
    
    output$valamiPlot <- renderPlot ({
        
    })
    
}

shinyApp (ui = ui , server = server)


