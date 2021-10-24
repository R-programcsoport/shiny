library (shiny)
library (leaflet)

df <- read.csv("adatb_tisztitott.csv", sep = ";", encoding = "UTF-8")
megyek <- df$Megye
epites <- df$`Építés típusa`
futes <- df$Futés
emelet <- df$Emelet
allapot <- df$`Ing. állapota`

ui <- fluidPage (
    
    titlePanel ("shiny shiny"),
    
    sidebarLayout (
        
        sidebarPanel (
            selectizeInput("megye", "megye kiválasztása", megyek ),
            selectizeInput("epites", "Építés típusa:", epites ),
            selectizeInput("futes", "fűtés típusa:", futes ),
            selectizeInput("emelet", "Emeleti elhelyezkedés:", emelet ),
            selectizeInput("allapot", "Ingatlan állapota:", allapot ),
            numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
            sliderInput("szoba", "Szobák száma:" , value = 2, min =0, max = 7)
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


