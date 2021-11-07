library (shiny)
library (leaflet)
library(tidyverse)
unique(df$regio)
df <- read.csv("adatb_regio.csv", encoding = "UTF-8")
betak <- read.csv("betak.csv")
regiok <- df$regio
epites <- df$epites_tipusa
futes <- df$futes
emelet <- df$emelet
allapot <- df$ing_allapota

ui <- fluidPage (
    
    theme = bslib::bs_theme (bootswatch = "darkly"),
  
    titlePanel ("Ingatlanpiac elemzése"),
    #menü
    navbarPage("Menü",
               #1. tab - hisztogram
               tabPanel("Lakásárak hisztogramja",
                        sidebarLayout (
                          sidebarPanel (selectInput("regiok", "Régió kiválasztása", regiok , selected="Budapest"),
                                        selectInput("epites", "Építés típusa:", epites),
                                        selectInput("futes", "fűtés típusa:", futes ),
                                        # sliderInput("emelet", "Emeleti elhelyezkedés:", value = 2, min=-1, max =15 ),
                                        selectInput("allapot", "Ingatlan állapota:", allapot ),
                                        numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
                                        sliderInput("eszoba", "Egész szobák száma:" , value = 2, min =0, max = 7),
                                        sliderInput("fszoba", "félszobák száma:" , value = 2, min =0, max = 7),
                                        textOutput("text")),
                          
                          # ábra
                          mainPanel (plotOutput("distPlot")))),
               
               #2. tab - lista
               tabPanel("Lakások listája",
                        sidebarLayout (
                          sidebarPanel (selectizeInput("regiok", "Régió kiválasztása", regiok , selected="Budapest"),
                                        selectizeInput("epites", "Építés típusa:", epites),
                                        selectizeInput("futes", "fűtés típusa:", futes ),
                                        # sliderInput("emelet", "Emeleti elhelyezkedés:", value = 2, min=-1, max =15 ),
                                        selectizeInput("allapot", "Ingatlan állapota:", allapot ),
                                        numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
                                        sliderInput("eszoba", "Egész szobák száma:" , value = 2, min =0, max = 7),
                                        sliderInput("fszoba", "félszobák száma:" , value = 2, min =0, max = 7),
                                        textOutput("text")),
                          
                          # lista
                          mainPanel (dataTableOutput ("adatok")))),
               
               #3. tab - becslés
               tabPanel("Becslés",
                        sidebarLayout (
                          sidebarPanel (selectizeInput("regiok", "Régió kiválasztása", regiok , selected="Budapest"),
                                        selectizeInput("epites", "Építés típusa:", epites),
                                        selectizeInput("futes", "fűtés típusa:", futes ),
                                        # sliderInput("emelet", "Emeleti elhelyezkedés:", value = 2, min=-1, max =15 ),
                                        selectizeInput("allapot", "Ingatlan állapota:", allapot ),
                                        numericInput("nm", "Hány négyzetméter?", value = 50, min = 0, max = 100),
                                        sliderInput("eszoba", "Egész szobák száma:" , value = 2, min =0, max = 7),
                                        sliderInput("fszoba", "félszobák száma:" , value = 2, min =0, max = 7),
                                        textOutput("text")),
                          
                          # becslés kiírítása
                          mainPanel (verbatimTextOutput ("valamiPlot")))),
               
               #4. tab - régiónkénti statisztika
               tabPanel("Árak leíró statisztikája régiónként",
                        sidebarLayout(sidebarPanel (
                          radioButtons (inputId = "gomb4",
                                        label = "Változók" ,
                                        choices = c ("Budapest",
                                                     "Del_Dunantul",
                                                     "Del_Alfold",
                                                     "Eszak_Magyarorszag",
                                                     "Eszak_Alfold",
                                                     "Kozep_Dunantul",
                                                     "Pest"))),
                          mainPanel(verbatimTextOutput ("leiro")))),

               
    ))

server <- function (input, output) {
    
    output$valamiPlot <- renderPlot ({
        
        regio_0 <- ifelse(input$regiok == "Budapest",22890.8954,ifelse(input$regiok == "Del_Dunantul",1742.4534, ifelse(input$regiok == "Del_Alfold",0,ifelse(input$regiok == "Eszak_Magyarorszag",-13941.2071,ifelse(input$regiok == "Eszak_Alfold" ,-2653.0765,ifelse(input$regiok =="Kozep_Dunantul",3651.7846, ifelse(input$regiok == "Pest",2626.0978, -7327.6158)))))))
        regio_1 <- ifelse(input$regiok == "Budapest",26773.0578,ifelse(input$regiok == "Del_Dunantul",6822.1720, ifelse(input$regiok == "Del_Alfold",0,ifelse(input$regiok == "Eszak_Magyarorszag",-9052.4014,ifelse(input$regiok == "Eszak_Alfold" ,4022.5860,ifelse(input$regiok =="Kozep_Dunantul",8569.6903, ifelse(input$regiok == "Pest",7458.3560, -1876.7824)))))))
        allapot_0 <- ifelse(input$allapot == "jó állapotú", 496.0745, ifelse(input$allapot == "felújított",9773.5857 ,ifelse(input$allapot == "közepes állapotú",-2241.7676 , ifelse(input$allapot == "felújítandó",0 ,ifelse(input$allapot == "építés alatt",-588.7225 , ifelse(input$allapot == "újszerű", 9641.4908,9560.0950 ))))))
        allapot_1 <- ifelse(input$allapot == "jó állapotú", 3610.2951, ifelse(input$allapot == "felújított",13049.3115 ,ifelse(input$allapot == "közepes állapotú",1249.2184 , ifelse(input$allapot == "felújítandó",0 ,ifelse(input$allapot == "építés alatt",4123.3078 , ifelse(input$allapot == "újszerű", 12932.9538,12992.5462 ))))))
        futes_0 <- ifelse(input$futes == "tavfutes", -13775.3213,ifelse(input$futes == "kozponti", -11920.8465,ifelse(input$futes == "egyeb",0 , ifelse(input$futes == "gaz", -10133.0781,-13815.3794))))
        futes_1 <- ifelse(input$futes == "tavfutes", -10312.0114,ifelse(input$futes == "kozponti", -9139.0789,ifelse(input$futes == "egyeb",0 , ifelse(input$futes == "gaz",-7297.4525,-9940.2162))))
        epites_0 <- ifelse(input$epites == "panel",-6918.0025 , ifelse(input$epites == "tégla",5396.5884 ,0))
        epites_1 <- ifelse(input$epites == "panel",-1901.2460 , ifelse(input$epites == "tégla",9982.0008 ,0))
        # emelet <- input$emelet
        terulet <- input$nm
        eszoba <- input$eszoba
        fszoba <- input$fszoba
        y_0 <- round(max(0, -22352.0123 + terulet*518.9742 +eszoba*6127.9906+fszoba*1962.9226 + regio_0+allapot_0+futes_0+epites_0))
        y_1 <- round(max(0,-15449.0374 + terulet*544.1307 +eszoba*7076.3211+fszoba*2966.9356 + regio_1+allapot_1+futes_1+epites_1))
        output$text <- renderText(paste("A megadott paraméterek szerint a kiválasztott ingatlan körülbelül:", y_0 , "és", y_1, "ezer Ft között van."))
    })

    
    
    subdata <- reactive ({
      
      
      regio_p <- switch(input$regiok,
                        "Budapest"="Budapest",
                        "Del_Dunantul"="Del_Dunantul",
                        "Del_Alfold"="Del_Alfold",
                        "Eszak_Magyarorszag"="Eszak_Magyarorszag",
                        "Eszak_Alfold"="Eszak_Alfold",
                        "Kozep_Dunantul"="Kozep_Dunantul",
                        "Pest"="Pest")
      
      allapot_p <- switch (input$allapot ,
                           "jó állapotú"="jó állapotú",
                           "felújított"="felújított",
                           "közepes állapotú"="közepes állapotú",
                           "felújítandó"="felújítandó",
                           "építés alatt"="építés alatt",
                           "újszerű"="újszerű")
      
      epites_p <- switch (input$epites ,
                          "panel"="panel",
                          "tégla"="tégla")
      
      futes_p <- switch (input$futes ,
                          "tavfutes"="tavfutes",
                          "kozponti"="kozponti",
                          "egyeb"="egyeb",
                          "gaz"="gaz")
      
      terulet_p <- input$nm
      
      eszoba_p <- input$eszoba
      
      fszoba_p <- input$fszoba
      
      df %>% 
        filter (regiok == regio_p & allapot==allapot_p & epites==epites_p & futes==futes_p & terulet_m_2>=terulet_p & egesz_szoba>=eszoba_p & felszobak_szama>=fszoba_p)
      
    })
    
    subdata2 <- reactive ({
      
      
      regio_p <- switch(input$regiok,
                        "Budapest"="Budapest",
                        "Del_Dunantul"="Del_Dunantul",
                        "Del_Alfold"="Del_Alfold",
                        "Eszak_Magyarorszag"="Eszak_Magyarorszag",
                        "Eszak_Alfold"="Eszak_Alfold",
                        "Kozep_Dunantul"="Kozep_Dunantul",
                        "Pest"="Pest")
      
      df %>% 
        filter (regiok == regio_p)
      
    })
    
    
    
    
    output$distPlot <- renderPlot ({
      
      ggplot (subdata ()) +
        geom_histogram (aes (x = ar_e_ft), binwidth = 2000, fill=I("blue"), alpha=I(.2), color="darkblue")+
        theme_classic()+
        labs(title="Árak ", x="Lakás ára (ezer forint)", y="Lakások száma")
      
    })
    
    
    
    
    
    output$distPlot_2 <- renderPlot ({
      
      ggplot (df ()) +
        geom_histogram (aes (x = ar_e_ft), binwidth = 2000, fill=I("blue"), alpha=I(.2), color="darkblue")+
        theme_classic()+
        labs(title="Árak ", x="Lakás ára (ezer forint)", y="Lakások száma")
      
    })
    
    
    output$adatok <- renderDataTable ({
      
      subdata ()
      
    })
    
    
    output$leiro <- renderPrint ({
      
      psych::describe (subdata2())
    })
    
}

shinyApp (ui = ui , server = server)


