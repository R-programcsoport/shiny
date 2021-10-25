library (shiny)
library (leaflet)

df <- read.csv("adatb_regio.csv", encoding = "UTF-8")
betak <- read.csv("betak.csv")
megyek <- df$megye
epites <- df$epites_tipusa
futes <- df$futes
emelet <- df$emelet
allapot <- df$ing_allapota
df$regio <- fct_collapse(df$megye,
                                                      Del_Alfold = c("Bács-Kiskun", "Békés", "Csongrád"),
                                                      Del_Dunantul = c( "Baranya", "Somogy"),
                                                      Eszak_Alfold = c("Hajdú-Bihar", "Jász-Budapestgykun-Szolnok", "Szabolcs-Szatmár-Bereg"),
                                                      Eszak_Magyarorszag = c("Borsod-Abaúj-Zemplén", "Nógrád"),
                                                      Kozep_Dunantul = c("Fejér", "Komárom-Esztergom","Veszprém"),
                                                      Nyugat_Dunantul = c("Gyor-Moson-Sopron","Vas", "Zala"),
                                                      Pest="Pest",
                                                      Budapest="Budapest")

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


