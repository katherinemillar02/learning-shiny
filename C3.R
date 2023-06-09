# loading in the packagfes 
library(shiny)

# ui cocde 
ui <- fluidPage(
  
)
# basic server 
server <- function(input, output, session) {
  
}

# loading the ap[ ]
shinyApp(ui, server)


# actually using inputs 

ui <- fluidPage(
  numericInput("count", label = "Number of values", value = 100)
)


# basic server 
server <- function(input, output, session) {
  
}

# loading the app 
shinyApp(ui, server)



# changing what can be done with the server 

server <- function(input, output, session) {
  message("The value of input$count is", input$count)
}
# ERROR 



# running the app
shinyApp (ui, server)


# trying output as suppose to input 

ui <- fluidPage(
  textOutput("flies")
)

# an example of an error because you forget the render function

server <- function(input, output, session) {
  output$greeting <- renderText("hello flies")
}


# REACTIVE PROGRAMMING 

ui <- fluidPage(
  textInput("name", "flies name"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  output$greeting <- renderText( {
    paste0("hey", input$name, "!")
  })
}


shinyApp(ui, server)




