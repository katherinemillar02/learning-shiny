# loading the packages in 
library(shiny)
library(vroom)
library(tidyverse)
library(readxl)
library(shiny)

# get data on your own computer 
dir.create("neiss")
#> Warning in dir.create("neiss"): 'neiss' already exists
download <- function(name) {
  url <- "https://github.com/hadley/mastering-shiny/raw/master/neiss/"
  download.file(paste0(url, name), paste0("neiss/", name), quiet = TRUE)
}
download("neiss/injuries.tsv.gz")
download("population.tsv")
download("products.tsv")


# leave this chapter for now until you can work the data? 

# trying with own data 

# uploading the data 

all_parkrun <- read_excel("all_parkrun.xlsx")



# exploring the data 

selected <- all_parkrun  %>% filter(time == 35.5)
nrow(selected)
#> [1] 2993
# trying again 
selected <- all_parkrun  %>% filter(time == 29.25)


# looking at summaries 
# struggling to relate this to the data? 
allparkruns_summary <- all_parkrun %>% 
  count(time, person, date)

allparkruns_summary_plot <- allparkruns_summary %>% 
  ggplot(aes(date, time, colour = person)) + 
  geom_line() + 
  labs(y = "time")

# spike in longer times between 2021/2022 and in 2023 

summary_test <- all_parkrun %>% 
  count(time, person, date) %>% 
  left_join(time, by = c("person", "parkrun")) %>% 
  mutate(rate = n / time * 1e4)

summary_test

# getting somewhere but code doesn't work 

allparkruns_summary %>% 
  ggplot(aes(date, time, colour = person)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

# testing code for named variables 
all_parkrun %>% 
  sample_n(10) %>% 
  pull(parkrun)


# prototypes 

# building a complex app - start simple 
# start with input - 


# making a variable/ tibble for something which will show the parkrun with the parkrun time 
parkrun_times <- setNames(all_parkrun$time,  all_parkrun$parkrun)

# making a variable/ tibble for something which will show the person with the parkrun time 
person_times <- setNames(all_parkrun$time,  all_parkrun$person)


person_date <- setNames(all_parkrun$person, all_parkrun$date)

# creating a ui 
ui <- fluidPage(
  fluidRow(
    column(6,
           selectInput("time", "parkrun", choices = parkrun_times) # select for the parkrun
    )
  ),
  fluidRow(
    column(6,
           selectInput("time", "person", choices = person_times) # select for the person 
    )
  ),
  fluidRow(
    column(6,
           selectInput("person", "date", choices = person_date) # select for the person and date
    )
  ),
  fluidRow(
    column(4, tableOutput("parkrun")),
    column(4, tableOutput("person")),
  ),
  fluidRow(
    column(12, plotOutput("time"))
  )
)



# server function 
server <- function(input, output, session) {
  selected <- reactive(all_parkrun %>% filter(parkrun_times == input$time))
  selected <- reactive(all_parkrun %>% filter(person_times == input$time))
  output$parkrun <- renderTable(
    selected() %>% count(parkrun, time, person, date, sort = TRUE)
  )
  output$person <- renderTable(
    selected() %>% count(person, time, sort = TRUE)
  )
  output$parkrun <- renderTable(
    selected() %>% count(parkrun, time, sort = TRUE)
  )
}

allparkruns_summary <- reactive({
  all_parkrun() %>%
    count(date, time, person) 

})
  
output$person_times <- renderPlot ({
  allparkruns_summary %>% 
    ggplot(aes( time, color = person)) 
})

# run the app 
shinyApp(ui, server)


# sort of works 
# Error in output$person_times <- renderPlot({ : object 'output' not found



library(shiny)

# trying again with creating own ui and server

# ui 

ui <- fluidPage(
  fluidRow(
    column(6, 
            selectInput("time", "parkrun",
                        choices = all_parkrun )
      
    )
  )
)


# server 


server <- function(input, output, session) {
  all_parkrun <- reactive(all_parkrun %>% filter == input$time)
}



# run app 
shinyApp(ui, server)




# polsih tables 

# components are somewhat in place - improve app 
# do not want all the information shown, just want the highlights 
# truncate the tables 
# can use forcats functions 
# convert the variable to a factor, order by the frequency of the levels - lump together after the top 5 


                                                     
