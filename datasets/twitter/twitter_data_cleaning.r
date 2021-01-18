options( RCurlOptions = list(verbose = TRUE,proxy = "host:port"))
install.packages("rtweet")
library(rtweet)

install.packages("readr")
library(readr)

install.packages("tidyverse")
library(tidyverse)

#Clean Dataset 1
ids_1 <- read_csv("C:/Users/User/Documents/R/hatespeech/NAACL_SRW_2016.csv", col_types = cols(statusid = col_character()))
messages_1 <- lookup_tweets(ids_1$statusid)

#authenticate Twitter login

ids_1$text <- messages_1$text[match(ids_1$statusid, messages_1$status_id)]
ids_1 <- ids_1[!is.na(ids_1$text),]
ids_1 <- ids_1[c(2,3)]
ids_1$classify[ids_1$classify == "none"] <- "neither"

#Clean Dataset 2
ids_2 <- read_delim("C:/Users/User/Documents/R/hatespeech/NLP+CSS_2016.csv", "\t", escape_double = FALSE, col_types = cols(TweetID = col_character()), na = "null", trim_ws = TRUE)
ids_2 <- ids_2[c(1:52)]

ids_2[ids_2 == "link"] <- "neither"
ids_2$neither <- apply(ids_2 == "neither", 1, sum)
ids_2$sexism <- apply(ids_2 == "sexism" | ids_2 == "both", 1, sum)
ids_2$racism <- apply(ids_2 == "racism" | ids_2 == "both", 1, sum)

ids_2$classify <- 0

ids_2$classify <- t(apply(ids_2[-1:-52], 1, FUN = function(x) names(head(sort(-x),2))))
ids_2$classify <- ids_2$classify[,1]
ids_2 <- ids_2 %>% select(1,56)

messages_2 <- lookup_tweets(ids_2$TweetID)

#authenticate Twitter login

ids_2$text <- messages_2$text[match(ids_2$TweetID, messages_2$status_id)]
ids_2 <- ids_2[!is.na(ids_2$text),]
ids_2 <- ids_2[c(2,3)]

#Write data into files
write.csv(ids_1, "twitterdata_1.csv", row.names = TRUE, col.names = TRUE)
write.csv(ids_2, "twitterdata_2.csv", row.names = TRUE, col.names = TRUE)