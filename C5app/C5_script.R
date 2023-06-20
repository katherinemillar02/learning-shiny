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

ui <- fluidPage(
  selectInput("parkrun", "parkrun", choices = unique(parkrun_data$parkrun)),
  tableOutput("selected")
)

server <- function(input, output, session) {
  selected <- reactive(parkrun_data[parkrun_data$parkrun == input$parkrun, ] )
  output$selected <- renderTable(head(selected(), 10))
}


shinyApp(ui, server)
