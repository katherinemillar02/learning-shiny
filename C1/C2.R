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

# loading the app
shinyApp(ui, server) 
