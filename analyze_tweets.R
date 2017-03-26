# Author:   Karina Shyrokykh
# Date:     26-03-2017
# Project:  Analysis of the first reaction to mass protests 
#           and the subsequent arrests in Belarus (25-03-2017)
# Function: Analyze downloaded tweets

# use necessary packages from the web
library("twitteR")
library("tm")
library("SnowballC")
library("dplyr")
library(wordcloud)
# library(RCurl)
library(RColorBrewer)

# Clear up the workspace
rm(list=ls()) 

# set working directory
setwd("C:/Users/Lokaladmin/Desktop/DATA SCIENCE/dzen_voli_tweets/")

# Belarus_en_corpus <- readLines("data/Belarus_en_corpus.txt")
# Belarus_en_corpus <- Corpus(VectorSource(Belarus_en_corpus))

sprintf("Downloading data")

Belarus_en_data_frame <- read.csv(file="data/Belarus_en_tweets.csv",
                              sep=",", 
                              header=T)
# Belarus_by_tweets <- read.csv(file="data/Belarus_by_tweets.csv",
#                               sep=",", 
#                               header=T)

# create corpus from the list of tweets
Belarus_en_corpus <- Corpus(VectorSource(Belarus_en_data_frame$text))

# Clean up corpus for analysis
Belarus_en_corpus <- tm_map(Belarus_en_corpus, content_transformer(function(x) iconv(x, to='UTF-8', sub='byte')), mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, content_transformer(function(x) gsub("http[^[:space:]]*", "", x)), mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, content_transformer(function(x) gsub("[^[:alnum:]///' ]", "", x)), mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, content_transformer(function(x) gsub("[^0-9A-Za-z///' ]", "", x)), mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, content_transformer(tolower), mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, tolower)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, removePunctuation, mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, function(x)removeWords(x,stopwords()), mc.cores=1)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, PlainTextDocument)
Belarus_en_corpus <- tm_map(Belarus_en_corpus, removeNumbers)

# plot  word cloud
wordcloud(Belarus_en_corpus, scale=c(5,0.5), max.words=250, random.order=FALSE,
          ot.per=0.35, use.r.layout=FALSE,colors=brewer.pal(8,"Dark2"))

sprintf("DONE!")