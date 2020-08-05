# Add interactive plot output

# Similar to creating interactive tables, we can easily turn a static plot created using ggplot2 into an interactive plot using the plotly package. 
# To render an interactive plot, use plotly::renderPlotly(), and display it using plotly::plotlyOutput().

ui <- fluidPage(
  selectInput('name', 'Select Name', top_trendy_names$name),
  # CODE BELOW: Add a plotly output named 'plot_trendy_names'
  plotly::plotlyOutput('plot_trendy_names')
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  # CODE BELOW: Render a plotly output named 'plot_trendy_names'
  output$plot_trendy_names = plotly::renderPlotly({
    plot_trends()
  })
  
}
shinyApp(ui = ui, server = server)