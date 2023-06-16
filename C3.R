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

server <- function(input, output, session) {
  output$greeting <- renderText(paste0("Drossie ", input$name))
}

# fixed 

server <- function(input, output, session) {
  output$greeting <- renderText(paste0("Droso ", input$name))
  
}

# fixed 


server <- function(input, output, server) {
  output$greting <- renderText(paste0("Hello", input$name))
}

# run the app
shinyApp(ui, server)



# draw the reactive graph for the following server functions




# motivation and ggplot2 

library(ggplot2)

freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )
  
  ggplot(df, aes(x, colour = g)) +
    geom_freqpoly(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}


t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
  
  # use sprintf() to format t.test() results compactly
  sprintf(
    "p value: %0.3f\n[%0.2f, %0.2f]",
    test$p.value, test$conf.int[1], test$conf.int[2]
  )
}


x1 <- rnorm(100, mean = 0, sd = 0.5)
x2 <- rnorm(200, mean = 0.15, sd = 0.9)

freqpoly(x1, x2)
cat(t_test(x1, x2))
#> p value: 0.005
#> [-0.39, -0.07]



 
                               # Modify this to be your own 
ui <- fluidPage(
  fluidRow(
    column(4, 
           "Distribution 1",
           numericInput("n1", label = "n", value = 100, min = 1),
           numericInput("mean1", label = "µ", value = 0, step = 0.1),
           numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
    ),
    column(4, 
           "Distribution 2",
           numericInput("n2", label = "n", value = 100, min = 1),
           numericInput("mean2", label = "µ", value = 0, step = 0.1),
           numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
    ),
    column(4,
           "Frequency polygon",
           numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
           sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
    )
  ),
  fluidRow(
    column(9, plotOutput("hist")),
    column(3, verbatimTextOutput("ttest"))
  )
)


                                 # The server 
server <- function(input, output, session) {
  output$hist <- renderPlot({
    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)
    
    freqpoly(x1, x2, binwidth = input$binwidth, xlim = input$range)
  }, res = 96)
  
  output$ttest <- renderText({
    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)
    
    t_test(x1, x2)
  })
}

shinyApp(ui, server)
