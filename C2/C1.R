# loading the shiny package in 
library(shiny)

# learning the ui (user interface)
# learning the server function (how the app works)

# creating app, directory and file 
# app.R 

# defining the ui - the actual HTML webpage 
ui <- fluidPage(
  "I love flies"
)

# specifying the behaviour of the app (this is an empty one)
server <- function (input, output, session) {
  
}

# constructing shiny application from ui and server 
shinyApp(ui, server)


# practicing ui controls 
# showing data frames in data set package

# fluidpage - layout function - basic visual structure of page 
ui <- fluidPage(
  # input control - user can add a value to interact with the app (data set from R)
  selectInput("dataset", label = "Fly", choices = ls("package:datasets")),
  # where to put rendered output
  verbatimTextOutput("summary"),
  tableOutput("table")
)


# telling shiny how to fill summary and table outputs 
server <- function(input, output, session) {
  # providing output for shiny with that id <- render function to wrap some code
  # render functions will produce a particular output (text-print, tables, plots)
  # render print paired with verbatimTextOutput
  output$summary <- renderPrint ({
    dataset <- get(input$dataset, "package:datasets")
    # data can change because input dataset was used, reactivity - inputs can change? 
  })
  # render table paired with tableOutput 
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}


# constructing shiny application from ui and server 
shinyApp(ui, server)

# dataset <- get(input$dataset, "package:datasets") has been used twice using REACTIVE EXPRESSIONS
# a REACTIVE EXPRESSION will 

# --------------

# updating the same code of server 
# ui stays the same 

# fluidpage - layout function - basic visual structure of page 
ui <- fluidPage(
  # input control - user can add a value to interact with the app (data set from R)
  selectInput("dataset", label = "Fly", choices = ls("package:datasets")),
  # where to put rendered output
  verbatimTextOutput("summary"),
  tableOutput("table")
)


server <- function(input, output, session) {
  # creating a reactive expression to minimise code
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    # calling the reactive expression the way one would a function
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}

# running app 
shinyApp(ui, server)



# EXERCISES !!!!!!!!!!!!

# app that decides on drosophila 

#
ui <- fluidPage(
  tableOutput("mortgage"),
  numericInput("age", "How many drosophila are there?", value = NA),
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function (input, output, session) ({
  output$greeting <- renderText({
    paste0("Drosophila ", input$name)
  })
  
  
  output$histogram <- renderPlot({
    hist(rnorm(1000))
  }, res = 96)
})

# running app 
shinyApp(ui, server)



# EXERCISE 2 


