
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("CRO Exchange"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("valuta", label = "Valuta:",
                  choices = list("EUR" = "EUR",
                                 "HRK" = "HRK",
                                 "AUD" = "AUD", 
                                 "CAD" = "CAD", 
                                 "CZK" = "CZK", 
                                 "DKK" = "DKK", 
                                 "HUF" = "HUF", 
                                 "JPY" = "JPY", 
                                 "NOK" = "NOK", 
                                 "SEK" = "SEK", 
                                 "CHG" = "CHG", 
                                 "GBP" = "GBP", 
                                 "USD" = "USD", 
                                 "PLN" = "PLN")),
      selectInput("tip", label = "Tip tecaja",
                  choices = list("srednji" = "srednji", 
                                 "kupovni" = "kupovni", 
                                 "prodajni" = "prodajni")),
      numericInput("iznos", label = "Iznos", value = 1.00, min = 0, step = .01)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3(textOutput("text1")),
      dataTableOutput(outputId = "tecajTable")
    )
  )
))
