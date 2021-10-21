library (shiny)
library (leaflet)
df <- adatb
megyek <- df$Megye
<<<<<<< HEAD
=======
epites <- df$`Építés típusa`
futes <- df$Futés
emelet <- df$Emelet
allapot <- df$`Ing. állapota`
>>>>>>> ad501cf34d386ae2ab3c473c8dc16601e3e1e861
ui <- fluidPage (
    
    titlePanel ("shiny shiny"),
    
    sidebarLayout (
        
        sidebarPanel (
<<<<<<< HEAD
            selectizeInput("megye", "megye kiválasztása", megyek )
=======
            selectizeInput("megye", "megye kiválasztása", megyek ),
            selectizeInput("epites", "Építés típusa:", epites ),
            selectizeInput("futes", "fűtés típusa:", futes ),
            selectizeInput("emelet", "Emeleti elhelyezkedés:", emelet ),
            selectizeInput("allapot", "Ingatlan állapota:", allapot ),
            numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
            sliderInput("szoba", "Szobák száma:" , value = 2, min =0, max = 7)
>>>>>>> ad501cf34d386ae2ab3c473c8dc16601e3e1e861
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


