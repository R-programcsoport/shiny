library (shiny)

ui <- fluidPage (
    
    titlePanel ("shiny shiny"),
    
    sidebarLayout (
        
        sidebarPanel (
            
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


