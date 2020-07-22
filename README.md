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


   


















