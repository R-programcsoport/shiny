library (shiny)
library (leaflet)

df <- read.csv("adatb_regio.csv", encoding = "UTF-8")
betak <- read.csv("betak.csv")
megyek <- df$regio
epites <- df$epites_tipusa
futes <- df$futes
emelet <- df$emelet
allapot <- df$ing_allapota

ui <- fluidPage (
    
    titlePanel ("shiny shiny"),
    
    sidebarLayout (
        
        sidebarPanel (
            selectizeInput("megye", "Régió kiválasztása", megyek ),
            selectizeInput("epites", "Építés típusa:", epites ),
            selectizeInput("futes", "fűtés típusa:", futes ),
            selectizeInput("emelet", "Emeleti elhelyezkedés:", emelet ),
            selectizeInput("allapot", "Ingatlan állapota:", allapot ),
            numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
            sliderInput("szoba", "Szobák száma:" , value = 2, min =0, max = 7),

            textOutput("text"),

        ),
        
        mainPanel (
            plotOutput ("valamiPlot")
        ),

    )
)


server <- function (input, output) {
    
    output$valamiPlot <- renderPlot ({
        output$text <- renderText("A megadott paraméterek szerint a kiválasztott ingatlan körülbelül:")  

    })
    
}

shinyApp (ui = ui , server = server)


