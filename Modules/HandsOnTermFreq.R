#手动计算词频
review_dtm_df = review_mat %>% 
  as.matrix() %>%
  as.data.frame() 
doc_id = rownames(review_dtm_df)
WC = WC %>% 
  mutate(doc = doc_id)
review_dtm_df %>% 
  as_tibble() %>% 
  mutate(doc = doc_id) %>% 
  pivot_longer(cols = !c(doc),
               names_to = "term",
               values_to = "freq") %>% 
  left_join(WC, by = "doc") %>% 
  mutate(TermFreq = freq/as.numeric(WC))