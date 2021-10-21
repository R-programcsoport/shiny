library (shiny)
library (leaflet)
df <- adatb
megyek <- df$Megye
ui <- fluidPage (
    
    titlePanel ("shiny shiny"),
    
    sidebarLayout (
        
        sidebarPanel (
            selectizeInput("megye", "megye kiválasztása", megyek ),
            numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
        ),
        
        mainPanel (
            plotOutput ("valamiPlot")
        ),

    )
)


server <- function (input, output) {
    
    output$valamiPlot <- renderPlot ({
        
    })
    
}

shinyApp (ui = ui , server = server)


