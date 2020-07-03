library(shiny)
library(HistData)
library(dplyr)
library(ggplot2)
library(scales)
#setwd("C:/Users/sgoyal/Desktop/Course/RMARKDOWN-LEAFLET")
download.file("https://covid.ourworldindata.org/data/owid-covid-data.csv",destfile = "./owid-covid-data.csv",method = "curl")
data<-read.csv("owid-covid-data.csv")
data$date <-as.Date(data$date)
covidnewcase<-select(data,date,new_cases)
covidcases<- na.omit(covidnewcase) 
days<-aggregate(covidcases["new_cases"], by=covidcases["date"], sum)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    myReactives <- reactiveValues(days = days)
    output$days.plot <- renderPlot({    
        appDates <- seq(Sys.Date() - input$`Days-Range`[2], Sys.Date() - input$`Days-Range`[1], by = "days")
        appData <- myReactives$days[myReactives$days$date %in% appDates, ]
        days.plot<-ggplot(data=appData, aes(x=date, y=new_cases,label = new_cases)) + geom_bar(stat="identity")    
        days.plot<-days.plot + theme(axis.text.x = element_text(angle = 45, hjust = 1))
        days.plot<-days.plot+ggtitle("Covid New Cases \n[Default Last 30 Days]")
        options(scipen=999)
        print(days.plot)
    })

})
