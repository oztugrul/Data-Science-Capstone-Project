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

