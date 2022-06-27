WC = summary(review_tokens) %>%
  as.data.frame() %>% 
  dplyr::select(Freq) %>% 
  transmute(WC = Freq) %>% 
  slice(1:10044)

review = review %>% 
  bind_cols(readability) %>% 
  bind_cols(sentiment) %>% 
  bind_cols(angry) %>% 
  bind_cols(anxious) %>% 
  mutate(Not_Disclosure = if_else(is.na(Gender)|is.na(Age)|Age == "|", 1, 0)) %>% 
  mutate(women = if_else(str_to_lower(Gender) == "female" & Not_Disclosure==0, 1, 0)) %>% 
  mutate(YoungAge = if_else(Age %in% c("25-34", "18-24", "13-17", "Another") & Not_Disclosure==0, 1, 0)) %>% 
  mutate(MidAge = if_else(Age == "35-49" & Not_Disclosure==0, 1, 0)) %>% 
  mutate(OldAge = if_else(Age %in% c("50-64", "65+") & Not_Disclosure==0, 1, 0)) %>% 
  mutate(Rating_Deviation = abs(AvgRatingStarsThisUser - Obs_Avg_Rating)) %>% 
  mutate(WC = WC$WC) %>% 
  mutate(HotelID = as_factor(HotelID)) %>% 
  mutate(year = str_extract(.$RatingDate, "^\\d*")) %>% 
  mutate(year = as_factor(year))

review = review %>% 
  mutate(women = if_else(is.na(women), 0, women)) %>% 
  mutate(YoungAge = if_else(is.na(YoungAge), 0, YoungAge)) %>% 
  mutate(MidAge = if_else(is.na(MidAge), 0, MidAge)) %>% 
  mutate(OldAge = if_else(is.na(OldAge), 0, OldAge))

review$WC = as.numeric(review$WC)