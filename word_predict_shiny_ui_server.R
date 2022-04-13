load("D:/ozge/Data Science Capstone/swiftkey_data/final/en_US/capstone.RData")

library(shiny)
library(quanteda)

library(ngram)

library(data.table)

library(tm)

library(stringr)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("simplex"),
                  titlePanel("Swiftkey Word Prediction"),
                  sidebarLayout(
                    sidebarPanel(
                      textAreaInput("test_input",label=h3("Enter some text"),value = "Write some words here ",width="250px",rows=2),      
                      actionButton("predict","Predict")
                      
                    ),
                    mainPanel(
                      h4("First Word Prediction:"),
                      verbatimTextOutput("word_predict_first"),
                      h4("Second Word Prediction:"),
                      verbatimTextOutput("word_predict_second"),
                      h4("Third Word Prediction:"),
                      verbatimTextOutput("word_predict_third")
                    )
                  )
))







#review_call_model, datalar, answer fonksiyonu, write fonksiyonu, to.plain fonksiyonu Environment'te tanımlı olmalıdır.

library(shiny)
library(shinythemes)

shinyServer(function(input,output) {
  model1pred<-eventReactive(input$predict, {
    as.character(word_prediction(input$test_input))[1]
  })
  
  model2pred<-eventReactive(input$predict, {
    as.character(word_prediction(input$test_input))[2]
  })
  model3pred<-eventReactive(input$predict, {
    as.character(word_prediction(input$test_input))[3]
  })
  
  
  
  
  output$word_predict_first<-renderText({
    model1pred()
  })
  output$word_predict_second<-renderText({
    model2pred()
  })
  output$word_predict_third<-renderText({
    model3pred()
  })
  
})

