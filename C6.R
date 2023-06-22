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
