# loading packages in 
library(shiny) 


# trying out text etc INPUTS with flies 
ui <- fluidPage(
  textInput("name", "What is the flies name?"),
  passwordInput("password", "What is the flies password?"),
  textAreaInput("story", "Tell me about the fly!", rows = 4)
)

# loading the app
shinyApp(ui, server)  


# trying out numeric etc INPUTS
ui <- fluidPage(
  numericInput("num", "Fly one", value = 0, min = 0, max = 50),
  sliderInput("num2", "Fly two", value = 50, min = 0, max = 60), 
  sliderInput("rng", "Range of flies", value = 50, min = 0, max = 60),
)


# trying out date inputs 

ui <- fluidPage(
  dateInput("dob", "When was the fly born?"),
  dateRangeInput("holiday", "When will the fly go to school?")
)


# loading the app
shinyApp(ui, server)  

# giving choices 
# listing types of drosophila fruit flies 

drosophila <- c("melanogaster", "funebris", "suzukii", "simulans", "bifurca")

ui <- fluidPage(
  selectInput("drosophila", "What's your fave drosophila", drosophila),
  radioButtons("drosophila", "What's your fave drosophila", drosophila)
)

# loading the app
shinyApp(ui, server) 


# radiobuttons but using icon emojis 

ui <- fluidPage(
  radioButtons("rb", "What mood is the fly in?:", 
               choiceNames = list(
                 icon("angry"),
                 icon("smile"),
                 icon("sad-tear")
               ),
               choiceValues = list("angry", "happy", "sad")
  ))


# loading the app
shinyApp(ui, server) 

# doing select input but in a way where you can have multiple elements
ui <- fluidPage(
  selectInput(
    "drosophila", "What's your fave drosophila?", drosophila,
    multiple = TRUE
  )
)

server <- function (input, output, session) {
  
}

# loading the app
shinyApp(ui, server) 


# creating a checkbox 

ui <- fluidPage(
  checkboxGroupInput("drosophila", "What drosophila do you like", drosophila)
)

# loading the app
shinyApp(ui, server)

# doing the same but with a single checkbox for a yes or no question say

ui <- fluidPage(
  checkboxInput("drosophila", "drosphila?", value = TRUE),
  checkboxInput("no drosophila", "no drosophila?")
)

# loading the app
shinyApp(ui, server)

# learning how to upload files 
ui <- fluidPage(
  fileInput("upload", NULL)
  # this particular function requires special handling from the *server*
)

# loading the app
shinyApp(ui, server)

# learning action buttons and links 
ui <- fluidPage(
  actionButton("click", "Click me!"),
  actionButton("hit", "Hit the fly!", icon = icon("fly"))
  # these buttons are paired with observeevent or eventReactive in the server function
  
)

# loading the app
shinyApp(ui, server)

# customising appearence 
# done by the class argument 
# can use btns 
# e.g. buttons can span the entire width of the element 


ui <- fluidPage(
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("hit", "Hit the fly!", class = "btn-lg btn-success")
  ), 
  fluidRow(
    actionButton("eat", "Eat the fly!", class = "btn-block")
  )
)


# loading the app
shinyApp(ui, server)

# the class arguments will set the class attribute of the underlying html 
# affects how element is styled
# e.g. Bootstrap (CSS design system used by Shiny)



# EXERCISES

# 1. generate a ui for labelling a textbox, space inside the area 

ui <- fluidPage(
  textInput("name", "What's the drosophila's name?", value = "drosophila"),
  verbatimTextOutput("name")
)

ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code")
)
server <- function(input, output, session) {
  output$text <- renderText({ 
    "Hello friend!" 
  })
  output$code <- renderPrint({ 
    summary(1:10) 
  })
}

ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("print")
)
server <- function(input, output, session) {
  output$text <- renderText("hello!")
  output$print <- renderPrint("hello!")
}

ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
}


ui <- fluidPage(
  plotOutput("plot", width = "400px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}
ui <- fluidPage(
  dataTableOutput("table")
)
server <- function(input, output, session) {
  output$table <- renderDataTable(mtcars, options = list(pageLength = 5))
}

