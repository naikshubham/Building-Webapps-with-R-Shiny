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

### Inputs, Outputs and Layouts
- We can use other inputs other than textInput. E.g **`sliderInput`** that allows the user to select a year.
- A **`selectInput`** is a great way to allow for a selection from a list of fixed options, such as a preferences for a list of inputs.
- The **`numericalInput`** allows us to provide a range of numbers users can choose from, which they can increase or decrease using the little arrows.
- A **`dateRangeInput`** allows us to provide users with a set of dates, and a calender drop down appears when they click so they can select a specific one.

#### Input functions
- All input functions have their first argument, an `inputId` in common. The inputId needs to be a character string, and each input should have a unique id so we can refer to it in the server to make updates to the app.
- Many inputs have a label as their next argument, which is a character string that is often shown to the user to let them know what they should do with the input.
- From there, each input function has unique arguments that help us successfully build the app. A selectInput requires a list of choices. The user will automatically see the first choice in the list.

```python
selectInput("inputId", "label", choices = c("A", "B", "C"))
```

- A sliderInput requires value that the slider will be set at by default, then a min and max of the other values users can choose from.
- If at any time,we want to see the arguments to a Shiny input function, we can use the built-in R help by putting a question mark in front of a function name or by putting the name inside the help function. `help(checkboxInput)`

```python
sliderInput("inputId", "label", value=1925, min = 1900, max = 2000)
```

#### Where to use inputs
- We always use input functions in the UI of our app. Below app uses textInput and a selectInput.
- In the server, we can always refer to our input using input$inputId. This is why we need our ids to be unique. Otherwise we can't refer to them down in the server and use them to update the app appropriately.

```python
ui <- fluidPage(textInput("name", "Enter a name:"),
                selectInput("animal", "Python or R?", choices = c("dogs", "cats")),
                textOutput("greeting"),
                textOutput("answer")
                )
                
server <- function(input, output, session) {
    output$greeting <- renderText({
        paste("Do you prefer Python or R", input$name, "?")
       })
       
    output$answer <- renderText([
        paste("I prefer", input$animal, "!")
        })
}
```

### Outputs and render functions
- Render functions are used to build outputs in the server based on inputs and other things like other parts of a character string.
- The below app outputs two different character strings, one with a question and one with the answer. Given they're both character strings, it's appropriate to use the renderText function to create both outputs.

```python
ui <- fuildPage(
    textInput("name", "Enter a name:"),
    selectInput("animal", "Dogs or cats?", choices = c("dogs", "cats")),
    textOutput("question"),
    textOutput("answer")
)

server <- function(input, output, session){
    output$question <- renderText({
     paste("Do you prefer Python or R,", input$name, "?")
     })
     output$answer <- renderText({
     paste("I prefer", input$animal, "!")
     })
}
```
   
#### Other render functions
- Like inputs, Shiny provides a number of other render functions we can use to create a number of different kinds of outputs beyond just texts, including **rendertable, renderImage, renderPlot, and more.**
- Output functions are used back in the UI to display the outputs built in the server with render functions. Earlier we used, two `textOutput` functions to display both the question and the answer outputs.

#### Other output functions
- Like inputs and render functions, Shiny provides a wide variety of outputs depending on what kind of output we've built, whether that be a table, an image or a plot. **tableOutput(), dataTableOutput, imageOutput(), plotOutput()**
- htmlwidgets packages such as **DT, leaflet and plotly** allows us to build interactive data tables, maps, and plots as Shiny outputs. E.g, the DT package allows us to build interactive data tables versus static ones.
- Below code, will build an app creating an interactive data table version of a random 10% of the babynames dataset.

#### Non-shiny output and render functions
- We use `renderDT` function to build the output in the server, then the `DTOutput` in the ui to display the table called babynames_table.
- The interactive table is **sortable, searchable, plus users can choose to show 10, 25** or more enteries at a time.

```python
library(shiny)
library(babynames)

ui <- fluidPage(DT::DTOutput("babynames_table"))

server <- function(input, output){
    output$babynames_table <- DT::renderDT({
        babynames %>%
            dplyr::sample_frac(.1)
            })
         }
```

#### Add a table output
- In order to add any output to a Shiny app, you need to:

1. Create the output (plot, table, text, etc.).
2. Render the output object using the appropriate `render___` function.
3. Assign the rendered object to `output$x`.
4. Add the output to the UI using the appropriate `___Output` function.

#### Add an interactive table output
- There are multiple htmlwidgets packages like `DT, leaflet, plotly, etc.` that provide highly interactive outputs and can be easily integrated into Shiny apps using almost the same pattern. For example, we can turn a static table in a Shiny app into an interactive table using the DT package:

1. Create an interactive table using `DT::datatable()`.
2. Render it using `DT::renderDT()`.
3. Display it using `DT::DTOutput()`.

#### Add interactive plot output
- Similar to creating interactive tables, we can easily turn a static plot created using `ggplot2` into an interactive plot using the `plotly` package. To render an interactive plot, use **plotly::renderPlotly()**, and display it using **plotly::plotlyOutput()**.


























