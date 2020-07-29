# Add a select input
# Adding an input to a shiny app is a two step process, where you first add an ___Input(“x”) function to the UI 
# and then access its value in the server using input$x. 
ui <- fluidPage(
  titlePanel("What's in a Name?"),
  
  selectInput('sex', 'Choose M or F',selected='F',choices = c('M', 'F')),
  
  # Add plot output to display top 10 most popular names
  plotOutput('plot_top_10_names')
)

server <- function(input, output, session){
  # Render plot of top 10 most popular names
  output$plot_top_10_names <- renderPlot({
    # Get top 10 names by sex and year
    top_10_names <- babynames %>% 
      #Filter for the selected sex
      filter(sex == input$sex) %>% 
      filter(year == 1900) %>% 
      top_n(10, prop)
    # Plot top 10 names by sex and year
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
}

shinyApp(ui = ui, server = server)