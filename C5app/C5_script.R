library(shiny)

f <- function(x) g(x)
g <- function(x) h(x)
h <- function(x) x * 2 


# understanding tracebacks 

# code that will error 
f("a")

# then call traceback 
traceback()

# 1: f("a")
# 2: g(x)
# 3: h(x)

# cannot really use tracebacks in shiny, can't run code while app is running 
# shiny reprints traceback for you

# ui code 
ui <- fluidPage(
  selectInput("n", "N", 1:10),
  plotOutput("plot")
)


# server code 
server <- function(input, output, session) {
  output$plot <- renderPlot({
    n <- f (input$n)
    plot(head(cars, n))
  })
}

# run app
shinyApp(ui, server)

# if you run app and there is an erorr, flip the errors upside down to understand it more


# using the interactive debugger

if (input$value == "a") {
  browser()
}

if (my_reactive() < 0) {
  browser()
}



#read in the data 
parkrun_data <- read_excel("all_parkrun.xlsx")

# viewing the data 
parkrun_data

# running the rows
unique(parkrun_data$date)
unique(parkrun_data$parkrun_no)
unique(parkrun_data$parkrun)
unique(parkrun_data$time)
unique(parkrun_data$person)


# trying to write a simple app 


# running a ui 
ui <- fluidPage(
  selectInput("parkrun", "parkrun", choices = unique(parkrun_data$parkrun)),
  tableOutput("selected")
)


# running server function
server <- function(input, output, session) {
  selected <- reactive(parkrun_data[parkrun_data$parkrun == input$parkrun, ] )
  output$selected <- renderTable(head(selected(), 100))
}

# running the app code 
shinyApp(ui, server)

# this app allows you to choose a parkrun only and will then show the date, parkrun number, parkrun, time and person 
# can adapt this to have more rows? 


# trying out selecting a new thing 
parkrun_data[parkrun_data$parkrun == "colney-lane", ]

# removing nas - there aren't any though

head(parkrun_data$parkrun == "colney-lane", 100)

# see what that did 
subset(parkrun_data, parkrun == "colney-lane")

# look for NAs 
subset(parkrun_data, parkrun == NA) # code wrong but ignore this 

# can ignore rest of chapter regarding NAs as do not have NAs in this dataset? 

# debugging reactivity 
# reactive files in an unexpected order 
# debug - call print() - displaying vectors of data = puts quotes around strings, starts the line with [1]
# message() sends result to standard error - not standard output 
# technical terms describe output streams 
# do not usually notice, displayed in the same way when running interactively 
# app hosted elsewhere, output is sent to standard error - recorded in the logs 

# message() with glue::glue() = interleave text and values in a message 
# glue() = anything wrapped inside evaluated and inserted into the output 

library(glue)

name <- "katie"
message(glue("Hey {name}"))



# can use str() will print the detailed structure of an object 
# useful in checking you have the type of object you expect 


# an example of using glue in shiny 

ui <- fluidPage(
  sliderInput("maleflies", "maleflies", value = 1, min = 0 , max = 10), 
  sliderInput("femaleflies", "femlaeflies", value = 1, min = 0 , max = 10), 
  sliderInput("virginfemaleflies", "virginfemaleflies", value = 1, min = 0 , max = 10),
  textOutput("total")
)


server <- function(input, output, session) {
  observeEvent(input$maleflies, {
    message(glue("updating female flies from {input$femaleflies} to {input$maleflies * 2}"))
    updateSliderInput(session, "y", value = input$maleflies * 2)
  })

total <- reactive({
  total <- input$maleflies + input$femaleflies + input$virginfemaleflies
  message(glue("New total is {total}"))
})
  
output$total <- renderText({
  total()
})
}

# running packages again

library(shiny)
library(glue)

# code to run the app 
shinyApp(ui, server)


# reprex basics 

# running the library 

library(shiny)

# running the ui

ui <- fluidPage(
  selectInput("n", "N", 1:10),
  plotOutput("plot")
)

server <- function (input, output, session) {
  output$plot <- renderPlot({
    n <- input$n * 2 
    plot(head(cars, n))
  })
}
