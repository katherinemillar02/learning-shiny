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


# run the app
shinyApp(ui, server)


# Tabsets

# tabsetPanel() and tabPanel() will break a page into pieces 
# tabsetPanel() creates a container for any number of tabPanels() - can contain any other HTMl components 

# load libraries 
library(shiny)



ui <- fluidPage(
  tabsetPanel(
    tabPanel("import data",
             fileInput("file","data", buttonLabel = "upload"),
    textInput("delim", "delimiter (leave blank to guess)", ""),
    numericInput("rows", "rows to preview", 10, min = 1)
    
  ),
  tabPanel("set parameters"), 
  tabPanel("vis results")
))

# run the app 
shinyApp(ui, server)


# knowing tab user has selected - id argument to tabsetPanel() becomes input 

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textOutput("panel")
    ), 
    mainPanel(
      tabsetPanel(
        id = "tabset",
        tabPanel("panel 1", "one"),
        tabPanel("panel 2, two"),
        tabPanel("PNAEL 3", "PANEL")
      )
    )
  )
)

server <- function(input, output, session) {
  output$panel <- renderText({
    paste("current panel: ", input$tabset)
  })
}

# run the app 
shinyApp(ui, server)

 # this app tells you at the top which panel you have selected

# navlists and navbars 
# horizontal - fundamental limit to tabs you can use (esp if they have long titles)
# navbarPage() and navbarMenu() = two alternative layouts - more tabs with longer titles 
# navlistPanel() similar to tabsetPanel() but doesnt run tab titles horizontally 
# shows them vertically in a sidebar
# adds headings with plain strings 

ui <- fluidPage(
  navlistPanel(
    id = "tabset", 
    "heading 1", 
    tabPanel("panel 1", "panel one contents"), 
    "heasing deux", 
    tabPanel("p2", "p2 cont"), 
    tabPanel("p3", "p3 cont")
  )
)

shinyApp(ui, server) 


# navbarPage() another way of doing - runs the tab tiles horizontally 
# can use navbarMenu() to add drop down menus for an additional level of hierachy 

ui <- navbarPage(
  "page title",
  tabPanel("p1", "1"),
  tabPanel("p2", "2"),
  tabPanel("p3", "3"),
  navbarMenu("subpanels", 
             tabPanel("p4a", "four a"),
             tabPanel("p4b", "four b"), 
             tabPanel("p4c", "four c")

             
))

# sets the ability to create rich and satisyinbg apps 
# bootstrap : collection of HTML conventions, CSS styles, JS snippets 

# Themes 

# bootstrap = can theme with the bslib package 

fluidPage(
  theme = bslib::bs_theme()
)


# using bootstrap with shiny themes

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "sandstone"),
  sidebarLayout(
    sidebarPanel(
      textInput("txt", "text input: ", " text here"),
      sliderInput("slider", "slider input:", 1, 100, 30)
    ),
    mainPanel(
      h1(paste0("theme: sandstone")),
      h2("header 2"),
      p("texty")
    )
  )
)


# run the app 
shinyApp(ui, server)


theme <- bslib::bs_theme(
  bg = "yellow", 
  fg = "green",
  base_font = "Source Sans Pro"
)

# preview and customise your theme:: with setting ^^ 
# meant to open a shiny app showing what the theme looks like 
# provides you with interactive controls for customising the most important parameters 


# plot themes 
# may want to customise plots to match 
# can use thematic package
# themes ggplot2, lattice, base plots 
# calling thematic_shiny in server function will determine all settings from your app theme 
library(ggplot2)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"), 
  titlePanel("a themed plot"), 
  plotOutput("plot"), 
)

server <- function(input, output, session) {
  thematic::thematic_shiny()
  
  output$plot <- renderPlot({
    ggplot(mtcars, aes (wt, mpg)) + 
      geom_point() + 
      geom_smooth()
  }, res = 96)
}

