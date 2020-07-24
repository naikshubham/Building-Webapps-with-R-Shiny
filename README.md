# Building-Webapps-with-R-Shiny
Building interactive web applications with R shiny.

### First shiny app

#### Parts of a Shiny app
- Load Shiny
- Create the UI with HTML function
- Define a custom function to create the server
- Create an object called server, and then assigned to it should be a function with, at minimum, the arguments input and output, though there are optional arguments that help us create more advanced apps.
- Session argument to specify a specific session
- Run the app. We have to pass the UI and server objects, usually just called ui and server,as arguments.

```python
library(shiny)

ui <- fluidPage("Hello World")

server <- function(input,
                   output,
                   session){
                   
}

shinyApp(ui = ui, server = server)
```

#### Ask a question (with an input !)
- Shiny provides an function, `textInput`, that makes taking input possible. It takes 3 arguments : a unique id, that will be used to refer to this input, a label that is displayed to the user, and an optional default value, which we haven't used in the app.

```python
ui <- fluidPage(textInput("name", "Enter a name:"), textOutput("q"))
    
```

- Our full output, the question itself, is built in the server using the `renderText` function, and is assigned to an output object, output$q. Inside that we can use `paste` to create longer character string, and if we add `input$name`, we can access the name added using `textInput`.
- In the UI, use the textOutput function to display the output q.

```python
ui <- fluidPage(textInput("name", "Enter a name:"), textOutput("q"))"

server <- function(input, output){
    output$q <- renderText({
        paste("Do you prefer R or Python", input$name, "?")
        })
}
```

### Build a names explorer Shiny app
- Every shiny app has two components : a user interface(UI) and a server.

#### Add inputs (UI)
- First, we will add a `titlePanel` at the top, to display a nicely styled header.Next add a `textInput` to let the user enter their name.

```python
ui <- fluidPage(titlePanel("Baby Name Explorer"),
                textInput("name", "Enter Name", "David"),
                plotOutput('trend')
                )
```

#### Add outputs (UI/server)
- Next step is adding outputs. Our only output will be an empty plot created using ggplot2.
- Add output using 2 steps : First, render the output in  the server using `renderPlot` and assign it to the output list as an element named trend.
- The UI needs to known that plot needs to be displayed, so we can use the `plotOutput` and pass it the name of the output.

```python
server <- function(input, output, session){
    output$trend <- renderPlot({
        ggplot()
       })
    }
    
shinyApp(ui = ui, server = server)
```

#### Update layout (UI)
- We can place elements in the UI using layout functions. We will place the **textInput** inside **sidebarPanel** and the **plotOutput** inside **mainPanel**. Additionally, we place both of these panels inside **sidebarLayout**.

```R
ui <- fluidPage(
        titlePanel("Baby Name Explorer"),
        sidebarLayout(
            sidebarPanel(
            textInput('name', 'Enter Name', 'David')
        ),
        mainPanel(
            plotOutput('trend')
        )
       )
      )
```

#### Update output (server)
- Final step is creating a line plot showing the popularity of a name input by the user using ggplot2. Access the input as `input$name`.
- Use `geom_line` to generate a line plot of prop, the proportion of births in a given year with the selected name, versus year. To display separate lines based on sex, we will set color to sex.

```R
server <- function(input, output, session){
    output$trend <- renderPlot({
        data_name <- subset(babynames, name == input$name)
        ggplot(data_name) + 
            geom_line(aes(x=year, y=prop, color=sex))
        
        })
       }
```

















