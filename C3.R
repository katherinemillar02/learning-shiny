# loading in the packagfes 
library(shiny)

# ui code 
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



# run the app
shinyApp(ui, server)


# tip - have to hit enter first
# but shiny will peform an action if update 
# code doesn't tell shiny to create a string and send it to browser 
# just informs shiny how to create string if it needs to

# understanding imperative vs declarative code 




# reactive expressions

# tool that reduces duplication in reactive code by introducing additional nodes into the reactive graph

server <- function(input, output, session) {
  string <- reactive(paste0("Fly ", input$name, "!"))
  output$greeting <- renderText(string())
}

# run the app
shinyApp(ui, server)

# this way it actually happens as you do it


# execution order 

server <- function(input, output, session) {
  output$greeting <- renderText(string())
  string <- reactive(paste0("Hello ", input$name, "!"))
}


# run the app
shinyApp(ui, server)

# string has to be created 
#  just a different way of doing the code above 


# EXERCISES 

# ui code 

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

# server code 

server1 <- function(input, output, session) {
  output$greeting <- renderText({
    paste0 ("Drossy ", input$name, "!")
     })
}


shinyApp(ui, server)


server2 <- function(input, output, server) {
  greeting <- paste0("Hello ", input$name)
  output$greeting <- renderText(greeting)
}

server3 <- function(input, output, server) {
  output$greting <- paste0("Hello", input$name)
}


# run the app
shinyApp(ui, server)


