# load packages
library(Hmisc)
library(dplyr)
library(mdsr)
library(babynames)

# about data
BabynamesDist <- make_babynames_dist()
dim(BabynamesDist)
names(BabynamesDist)
tail(BabynamesDist)
# est_alive_today : 생존 수 추정값

# male name whose est_num_alive is under 100,000 
not_mybaby <- BabynamesDist %>% filter(sex=="M") %>% group_by(name) %>%
  summarise(est_num_alive = sum(est_alive_today)) %>%
  filter(est_num_alive<100000) %>% select(name)

mybaby <- BabynamesDist %>%
  anti_join(not_mybaby, by="name") %>%
  filter(sex == "M") %>%
  group_by(name) %>%
  summarise(
    N = n(), est_num_alive = sum(est_alive_today),
    q1_age = wtd.quantile(age_today, est_alive_today, probs = 0.25),
    median_age = wtd.quantile(age_today, est_alive_today, probs = 0.5),
    q3_age = wtd.quantile(age_today, est_alive_today, probs = 0.75)) %>%
  arrange(median_age) %>%
  head(26)

b.plot <- ggplot(data=mybaby, aes(x = reorder(name, -median_age), y=median_age)
                 ) + xlab(NULL) + ylab("Age") + ggtitle("Youngest Male Names")
b.plot + geom_linerange(
  aes(ymin = q1_age, ymax = q3_age),
  color = "#76bde0", 
  size=5, alpha=0.7
) + 
  geom_point(fill = "#ed3324", colour = "white", size = 4, shape = 21) +
  coord_flip()
