setwd("D:/ozge/Data Science Capstone/swiftkey_data/final/en_US")

blogs <- readLines("en_US.blogs.txt", encoding= "UTF-8", skipNul = TRUE)
news <- readLines("en_US.news.txt", encoding= "UTF-8", skipNul = TRUE)
twitter <- readLines("en_US.twitter.txt", encoding= "UTF-8", skipNul = TRUE)


library(quanteda)

library(ngram)

library(data.table)

library(tm)

library(stringr)
set.seed(1234)

blogs_sample <- sample(blogs, length(blogs) * 0.25)
twitter_sample<-sample(twitter, length(twitter) * 0.25)
news_sample<-sample(news, length(news) * 0.25)

to.plain <- function(s) {
  
  # 1 character substitutions
  
  old1 <- c("I")
  
  new1 <- c("i")
  
  s1 <- chartr(old1, new1, s)
  s1
  
}

plain<-to.plain(c(blogs,twitter,news))

plain_sample<-to.plain(c(blogs_sample,twitter_sample,news_sample))

lower <- tolower(plain)

lower_sample <- tolower(plain_sample)


corpus<-corpus(lower)

corpus_sample<-corpus(lower_sample)

corpus_tokens <- tokens(corpus,what = "word",
                               remove_punct = TRUE,
                               remove_symbols = TRUE,
                               remove_numbers = TRUE,
                               remove_url = TRUE,
                               remove_separators = TRUE,
                               split_hyphens = FALSE,
                               include_docvars = TRUE,
                               padding = FALSE)

sample_corpus_tokens <- tokens(corpus_sample,what = "word",
                        remove_punct = TRUE,
                        remove_symbols = TRUE,
                        remove_numbers = TRUE,
                        remove_url = TRUE,
                        remove_separators = TRUE,
                        split_hyphens = FALSE,
                        include_docvars = TRUE,
                        padding = FALSE)



rm(list=c("corpus","corpus_sample","blogs","news","twitter","lower","lower_sample","plain","plain_sample"))
rm("blogs_sample","news_sample","twitter_sample")

unigrams_dfm <- dfm(corpus_tokens)
unigrams_freq <- textstat_frequency(unigrams_dfm)  
unigrams_subset <- subset(unigrams_freq,select=c(feature,frequency))
names(unigrams_subset) <- c("term","frequency")
unigrams <- data.frame(unigrams_subset)
fwrite(unigrams,"unigrams.csv")
rm("unigrams_dfm","unigrams_freq","unigrams_subset")

bigrams_dfm <- dfm(tokens_ngrams(corpus_tokens, n = 2,concatenator = " "))
bigrams_freq <- textstat_frequency(bigrams_dfm)                    
bigrams_subset <- subset(bigrams_freq,select=c(feature,frequency))
names(bigrams_subset) <- c("term","frequency")
bigrams <- data.frame(bigrams_subset)
fwrite(bigrams,"bigrams.csv")
rm("bigrams_dfm","bigrams_freq","bigrams_subset")


trigrams_dfm <- dfm(tokens_ngrams(corpus_tokens, n = 3,concatenator = " "))
trigrams_freq <- textstat_frequency(trigrams_dfm)                  
trigrams_subset <- subset(trigrams_freq,select=c(feature,frequency))
names(trigrams_subset) <- c("term","frequency")
trigrams <- data.frame(trigrams_subset)
fwrite(trigrams,"trigrams.csv")
rm("trigrams_dfm","trigrams_freq","trigrams_subset")

quadgrams_dfm <- dfm(tokens_ngrams(sample_corpus_tokens, n = 4,concatenator = " "))
quadgrams_freq <- textstat_frequency(quadgrams_dfm)                  
quadgrams_subset <- subset(quadgrams_freq,select=c(feature,frequency))
names(quadgrams_subset) <- c("term","frequency")
quadgrams <- data.frame(quadgrams_subset)
fwrite(quadgrams,"quadgrams.csv")
rm("quadgrams_dfm","quadgrams_freq","sample_corpus_tokens","quadgrams_subset")


head(unigrams);head(bigrams);head(trigrams);head(quadgrams)


saveRDS(unigrams[which(unigrams$frequency >= 1),],"unigrams.rds")
unigrams_v2<-readRDS("unigrams.rds")

saveRDS(bigrams[which(bigrams$frequency >= 50),],"bigrams.rds")
bigrams_v2<-readRDS("bigrams.rds")

saveRDS(trigrams[which(trigrams$frequency >= 50),],"trigrams.rds")
trigrams_v2<-readRDS("trigrams.rds")

saveRDS(quadgrams[which(quadgrams$frequency >= 50),],"quadgrams.rds")
quadgrams_v2<-readRDS("quadgrams.rds")








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

