# Data-Science-Capstone-Project
Swiftkey Next Word Prediction

**https://rpubs.com/Ozge_Tugrul_Sonmez/728652**

**https://rpubs.com/Ozge_Tugrul_Sonmez/720932**

Algorithm:
If the number of the words entered is at least 3, then quadgram is searched for the last 3 words and and the three most frequent last word of the quadgrams are shown on the screen. Quadgrams which have a frequency more than 50 is used as data. If the quadgram is not found, then trigram is searched for the last 2 words and the three most frequent last word of the trigrams are shown on the screen. Trigrams which have a frequency more than 50 is used as data. If the trigram is not found, then bigram is searched for the last 1 word and the three most frequent last word of the bigrams are shown on the screen. Bigrams which have a frequency more than 50 is used as data. If the bigram is not found, then unigram is searched and the three most frequent unigrams are shown on the screen. When less than three words are found, then NA is returned in the place of the not founded predicted word.


If the number of the words entered is 2, then trigram is searched for the last 2 words and the three most frequent last word of the trigrams are shown on the screen. Trigrams which have a frequency more than 50 is used as data If the trigram is not found, then bigram is searched for the last 1 word and the three most frequent last word of the bigrams are shown on the screen. Bigrams which have a frequency more than 50 is used as data. If the bigram is not found, then unigram is searched and the three most frequent unigrams are shown on the screen. When less than three words are found, then NA is returned in the place of the not founded predicted word.


If the number of words entered is 1, then bigram is searched for the word and three most frequent last word of the bigrams are shown on the screen. Bigrams which have a frequency more than 50 is used as data. If the bigram is not found, then unigram is searched and the three most frequent unigrams are shown on the screen. When less than three words are found, then NA is returned in the place of the not founded predicted word.


If nothing is written on the screen or numbers/ punctuation is written, then the three most frequent unigrams are shown on the screen.


Data Used:
For unigrams, bigrams and trigrams complete data is used for frequency of the terms. For quadgram 25% of the data is randomly sampled for frequency of the terms since speed of finding terms decreases by using all of the data.


Elapsed time of the function is less than 3 seconds according to system.time() function.
