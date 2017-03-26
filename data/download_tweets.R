# Author:   Karina Shyrokykh
# Date:     26-03-2017
# Project:  Analysis of the first reaction to mass protests 
#           and the subsequent arrests in Belarus (25-03-2017)
# Function: Download tweets as a csv file

# PROGRESS =======================================================
# TODO:
# - Support for Cyrillic tweets
# DONE:
# - Downloading tweets, saving in csv as data frames, reading csvs
# ================================================================

# use necessary packages from the web
library("twitteR")
library("tm")
library("SnowballC")
library("dplyr")

# Clear up the workspace
rm(list=ls()) 

# set working directory
setwd("C:/Users/Lokaladmin/Desktop/DATA SCIENCE/dzen_voli_tweets/data/")

# # Necessary libs
# library(tm)
# library(wordcloud)
# library(twitteR)
library(RCurl)
# library(RColorBrewer)

# save credentials in a csv file so not to display private information publicly
credentials <- read.csv(file="C:/Users/Lokaladmin/Desktop/DATA SCIENCE/dzen_voli_tweets/data/credentials.csv", 
                        sep=",", 
                        header=F)

# Set up Twitter app authentication parameters
# by reading a table with credentials from a csv file
consumer_key    <- toString(credentials[1, "V1"])
consumer_secret <- toString(credentials[1, "V2"])
access_token    <- toString(credentials[1, "V3"])
access_secret   <- toString(credentials[1, "V4"])

# set up authentication with Twitter
setup_twitter_oauth(consumer_key, 
                    consumer_secret, 
                    access_token, 
                    access_secret)

sprintf("Downloading tweets...")

# search latest (n_tweets) tweets
n_tweets <- 10000

# create new objects containing text of tweets
Belarus_en_tweets     <- searchTwitter("#Belarus OR #Minsk OR #FreedomDay", 
                                     since="2017-03-25", 
                                     n=n_tweets)
# Belarus_by_tweets     <- searchTwitter("#ДзеньВолі OR #дармаеды OR #25сакавіка OR #Минск OR #Беларусь", 
#                                        since="2017-03-25", 
#                                        n=n_tweets)

# convert to data frames
Belarus_en_data_frame <- do.call("rbind", 
                                 lapply(Belarus_en_tweets, as.data.frame))
# Belarus_by_data_frame <- do.call("rbind", 
#                                  lapply(Belarus_by_tweets, as.data.frame))

# # check data frame dimensions
# dim(Belarus_en_data_frame)

# save data frames to csv file
write.csv(Belarus_en_data_frame,
          file="Belarus_en_tweets.csv")
# write.csv(Belarus_by_data_frame,
#           file="Belarus_by_tweets.csv")
sprintf("DONE!")


