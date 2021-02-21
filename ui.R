library(shiny)

library(quanteda)

library(ngram)

library(data.table)

library(tm)

library(stringr)

library(shinythemes)

shinyUI(navbarPage(
    
    "Coursera Swiftkey Word Prediction Project",theme = shinytheme("united"),
    tabPanel("Swiftkey Word Prediction",
             pageWithSidebar(
                 headerPanel("Predict Next Word (Most Frequent Three Words)"),
        sidebarPanel(
            textAreaInput("test_input",label=strong(h3("Enter some text")),value = "Write some words here ",width="250px",rows=2),      
            actionButton("predict","Predict")
            
        ),
        mainPanel(
            h4("First Next Word Prediction:"),
            verbatimTextOutput("word_predict_first"),
            tags$head(tags$style("#word_predict_first{color: red;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
            )
            ),
            h4("Second Next Word Prediction:"),
            verbatimTextOutput("word_predict_second"),
            tags$head(tags$style("#word_predict_second{color: green;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
            )
            ),
            h4("Third Next Word Prediction:"),
            verbatimTextOutput("word_predict_third"),
            tags$head(tags$style("#word_predict_third{color: purple;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
            )
            ),
        )
    )
),
tabPanel("Prediction Algorithm",
         fixedPanel(h3("Algorithm:"),
                   p("If the number of the words entered is at least 3, then quadgram is searched for the last 3 words and 
                   and the three most frequent last word of the quadgrams are shown on the screen.
                   Quadgrams which have a frequency more than 50 is used as data.
                     If the quadgram is not found, then trigram is searched for the last 2 words and 
                     the three most frequent last word of the trigrams are shown on the screen.
                     Trigrams which have a frequency more than 50 is used as data.
                     If the trigram is not found, then bigram is searched for the last 1 word and 
                     the three most frequent last word of the bigrams are shown on the screen.
                     Bigrams which have a frequency more than 50 is used as data.
                     If the bigram is not found, then unigram is searched  and 
                     the three most frequent unigrams are shown on the screen.
                     When less than three words are found, then NA is returned in the place of the not founded predicted word."),
br(),

                   
                    p("If the number of the words entered is 2, then trigram is searched for the last 2 words
                        and the three most frequent last word of the trigrams are shown on the screen.
                        Trigrams which have a frequency more than 50 is used as data
                      If the trigram is not found, then bigram is searched for the last 1 word and 
                     the three most frequent last word of the bigrams are shown on the screen.
                     Bigrams which have a frequency more than 50 is used as data.
                      If the bigram is not found, then unigram is searched  and 
                     the three most frequent unigrams are shown on the screen.
                      When less than three words are found, then NA is returned in the place of the not founded predicted word."),
br(),

                    p("If the number of words entered is 1, then bigram is searched for the word and three 
                      most frequent last word of the bigrams are shown on the screen.
                      Bigrams which have a frequency more than 50 is used as data.
                      If the bigram is not found, then unigram is searched  and 
                     the three most frequent unigrams are shown on the screen.
                      When less than three words are found, then NA is returned in the place of the not founded predicted word."),
br(),
                    p("If nothing is written on the screen or numbers/ punctuation is written, then the three most frequent unigrams are shown on the screen."),

br(),
h3("Data Used:"),

p("For unigrams, bigrams and trigrams complete data is used for frequency of the terms. 
  For quadgram 25% of the data is randomly sampled for frequency of the terms since speed
  of finding terms decreases by using all of the data."),
br(),
p("Elapsed time of the function is less than 2 seconds according to system.time() function.")

)),
         

tabPanel("Link to Project and Explanation",
         fixedPanel(h3("About Application:"),
                    p("The goal of this exercise is to create a product to highlight the prediction algorithm that you have built and to provide an interface that can be accessed by others."),
                    br(),
                    p("A Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word."),
                    br(),
                    h3("Coursera Data Science Project Link:"),
                    a("https://www.coursera.org/learn/data-science-project/peer/EI1l4/final-project-submission")
                    )
)
))




