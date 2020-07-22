
# hello world shinny app

library(shiny)

ui <- fluidPage(
  textInput("name", "Enter a name:"), textOutput("greeting")
)

server <- function(input, output, session){
  output$greeting <- renderText({paste("Hello, ", input$name)})  
}

shinyApp(ui = ui, server = server)
