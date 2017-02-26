
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

source("cro_exchange_lib.R")

shinyServer(function(input, output) {
  tecaj <- reactive({
    read_tecaj_hnb()
  })
  output$text1 <- renderText(
    paste("Primjenjuje se od ", tecaj()$datum_primjena)
  )
  output$tecajTable <- renderDataTable({
    tecaj_lst <- tecaj()
    #tecaj_lst$tecaj
    valuta_2_other(iznos = input$iznos, 
                   valuta = input$valuta, 
                   tip = input$tip, 
                   tecaj = tecaj_lst)
  },
    options=list(
                #iDisplayLength=13,      # initial number of records
                #aLengthMenu=c(14,1),    #records/page options
                bLengthChange=0,       # show/hide records per page dropdown
                bFilter=0,            # global search box on/off
                bInfo=0,  # information on/off (how many records filtered, etc)
                bAutoWidth=0, # automatic column width calculation, disable if passing column width via aoColumnDefs
                aoColumnDefs = list(list(sWidth="300px", aTargets=c(list(0),list(1))))    # custom column size                       
  ))
})
