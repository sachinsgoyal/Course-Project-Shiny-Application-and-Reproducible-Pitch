library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Covid New Cases For Range Selected"),

    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("Days-Range",
                        label="Range of Days:",
                        min=0,max=30, value = c(0,30))
        ),
        mainPanel(
            plotOutput("days.plot"))
        
    )
))