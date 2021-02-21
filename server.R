#review_call_model, datalar, answer fonksiyonu, write fonksiyonu, to.plain fonksiyonu Environment'te tanımlı olmalıdır.

library(shiny)
library(shinythemes)

load("unigrams.RData")
load("bigrams.RData")
load("trigrams.RData")
load("quadgrams.RData")


to.plain <- function(s) {
    
    # 1 character substitutions
    
    old1 <- c("I")
    
    new1 <- c("i")
    
    s1 <- chartr(old1, new1, s)
    return(s1)
    
}

word_prediction<- function(x) {
    x<-removeNumbers(x)
    #x<-gsub('[[:punct:] ]+',' ',x)
    x<-to.plain(x)
    x<-tolower(x)
    x<-str_trim(x)
    if (sapply(strsplit(x, " "), length)>= 3){
        x_lastthree<- word(x,start=-3,end=-1)
        x_lasttwo<- word(x,start=-2,end=-1)
        x_lastone<-word(x,start=-1,end=-1)
        if(nrow(quadgrams_v2[grep(paste("^",x_lastthree,sep=""), quadgrams_v2[,1]),])>0){
            return(word(head(quadgrams_v2[grep(paste("^",x_lastthree,sep=""), quadgrams_v2[,1]),], 3)$term,start=-1,end=-1))}
        else if(nrow(trigrams_v2[grep(paste("^",x_lasttwo,sep=""), trigrams_v2[,1]),])>0){
            return(word(head(trigrams_v2[grep(paste("^",x_lasttwo,sep=""), trigrams_v2[,1]),], 3)$term,start=-1,end=-1))}
        else if(nrow(bigrams_v2[grep(paste("^",x_lastone,sep=""), bigrams_v2[,1]),])>0){
            return(word(head(bigrams_v2[grep(paste("^",x_lastone,sep=""), bigrams_v2[,1]),], 3)$term,start=-1,end=-1))
        }
        else{return(unigrams_v2[1,1])}
    }
    else if (sapply(strsplit(x, " "), length)== 2){
        x_lasttwo<- word(x,start=-2,end=-1)
        x_lastone<-word(x,start=-1,end=-1)
        if(nrow(trigrams_v2[grep(paste("^",x_lasttwo,sep=""), trigrams_v2[,1]),])>0){
            return(word(head(trigrams_v2[grep(paste("^",x_lasttwo,sep=""), trigrams_v2[,1]),], 3)$term,start=-1,end=-1))}
        else if(nrow(bigrams_v2[grep(paste("^",x_lastone,sep=""), bigrams_v2[,1]),])>0){
            return(word(head(bigrams_v2[grep(paste("^",x_lastone,sep=""), bigrams_v2[,1]),], 3)$term,start=-1,end=-1))
        }
        else{return(head(unigrams_v2[,1],3))}
    }
    else if (sapply(strsplit(x, " "), length)== 1){
        if(nrow(bigrams_v2[grep(paste("^",x,sep=""), bigrams_v2[,1]),])>0) {
            return(word(head(bigrams_v2[grep(paste("^",x,sep=""), bigrams_v2[,1]),], 3)$term,start=-1,end=-1))
        }
        else{return(head(unigrams_v2[,1],3))}
        
    }else if (sapply(strsplit(x, " "), length)== 0){
        return(head(unigrams_v2[,1],3))
    }
    
    
}




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

