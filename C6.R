# reading packages in
library(shiny)

fluidPage(
  titlePanel("parkrun!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("runs", "parkruns", min = 0, max = 500, value = 500)
    ),
    mainPanel(
      plotOutput("distplot")
    )
  )

)

# just looking at the function calls 
# working out what means what
fluidPage(# classic app design?
  titlePanel( # title at the top? 
    sidebarLayout( # side bar? select? 
      sidebarPanel()
    ),
    mainPanel() # could be a plot? 
  )
)


# page functions 

fluidPage() # will set up the HTML/ CSS/ JavaScript 

fixedPage()  # similar to fluid page, max width - stops app becoming unreasonable
fillpage() # fills the full height of the browser - whole plot on screen e.g. 

# page with sidebar 
# comnplex apps - lauyout functions inside fluidPage() 

# inputs on left and outputs on the right 
fluidPage(
  titlePanel(
    # app title/description
  ),
  sidebarLayout(
    sidebarPanel(
      # inputs
    ),
    mainPanel(
      # outputs
    )
  )
)


# running the ui
ui <- fluidPage(
  titlePanel("Central limit theorem"),
  sidebarLayout(
    position = "right", 
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

# running the server 
server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}

# running the app
shinyApp(ui, server)



# multi-row 
# sidebarLayout() flexible multi row layout - create more complex apps 
# fluidPage() creates rows with fluidRow() and columns with column() 


# a strcuture with examples of columns 

fluidPage(
  fluidRow(
    column(4, 
           ...
    ),
    column(8, 
           ...
    )
  ),
  fluidRow(
    column(6, 
           ...
    ),
    column(6, 
           ...
    )
  )
)

# a row will always have 12 columns - number will show how many to occupy 


# exercises 
# sidebarlayout = the widht, in columns 



# creating an app with two plots 
# of which takes up half the width 

ui <- fluidPage(
  fluidRow(
    column(6,
           plotOutput("plot1")
           ),
    column(6,
           plotOutput("plot2"))
  )
)


server <- function(input, output, session) {
  output$plot1 <- renderPlot({
    plot(1:10, type ="1", main = "Plot 1")
  })
  output$plot2 <- renderPlot({
    plot(10:1, type = "1", main = "Plot 2" )
  })
}

shinyApp(ui, server)
