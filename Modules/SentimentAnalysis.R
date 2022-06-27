#情感分析
##syuzhet包
library(syuzhet)
sentiment = get_sentiment(review$ReviewText, method = "nrc") %>% 
  as_tibble() %>% 
  transmute(sentiment = value)
#https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html
#由于两种函数所包含的共同词典仅有nrc词典，所以均采用nrc词典进行情感提取


##quanteda/quanteda.sentiment包
library(quanteda.sentiment)
review_corpus = corpus(review$ReviewText)
sentiment = review_corpus %>% 
  textstat_polarity(dictionary = data_dictionary_NRC) %>% 
  as_tibble() %>% 
  dplyr::select("sentiment")

#Polarity-based sentiment. This is implemented via textstat_polarity(), for computing a sentiment based on keys set as “poles” of positive versus negative sentiment. Setting polarity is dones through the polarity()<- function and can be set for any dictionary, for any keys. “Sentiment” here can be broadly construed as any contrasting pair of poles, such as “Democrat” versus “Republican”, for instance. More than one key can be associated with the same pole.

#Polar values are converted into sentiment scores using a flexible function, such as log(pos/neg), or (pos − neg)/(pos + neg). quanteda.sentiment offers three built-in functions, but the user can supply any function for combining polarities.

#此处为和syuzhet包所得结果相比较，采用nrc词典即“两极”的情感评价方法

#https://github.com/quanteda/quanteda.sentiment，该R包未上线CRAN，故只能从github安装

#scale()