# This app will allow users to enter a baby name and visualize the popularity of that name over time.

# The first step is to add a text input to the UI that will allow a user to enter their (or any other) name. Try using the optional default argument this time around.

#1) Add a text input to the UI, with the inputId, 'name'. Pass it a label (e.g. 'Enter your Name'), and an appropriate default value (e.g. 'David').
#The next step in building your app is to add an empty plot as a placeholder. Recall that in order to add a plot p assigned to an object named x to a Shiny app, you need to:

# 1. Render the plot object using renderPlot({p}).
# 2. Assign the rendered plot to output$x.
# 3. Display the plot in the UI using plotOutput("x").

list.of.pkgs <- c("shiny",'ggplot2')
library(ggplot2)

ui <- fluidPage(
  titlePanel("Baby Name Explorer"),
  # Add a sidebarLayout, sidebarPanel, and mainPanel
  sidebarLayout(
    sidebarPanel(
      textInput('name', 'Enter Name', 'David'),
    ),
    mainPanel(plotOutput('trend')
    )
  )
)

server <- function(input, output, session) {
  output$trend <- renderPlot({
    # CODE BELOW: Update to display a line plot of the input name
    ggplot(data_name) + 
      geom_line(aes(x=year, y=prop, color=sex))
  })
}

shinyApp(ui = ui, server = server)