rm(list = ls()) 

library(foreign)
library(tibble)
library(dotwhisker)
library(broom)
library(dplyr)
library(sjPlot)
library(sjmisc)
library(ggplot2)
library(sjlabelled)

# Loading Data
rd<- read.dta("russiadata.dta")
rd<- 
  rd %>%
  select(foreign_treat,
         putin, democracy, female, age, russian,
         married, city, education, polinterest4, howreligious,
         orthodox, media_use3, mediachoice, socialmediause, 
         angryinsultputin, usattitudes, regimesupport, pass) %>% 
  na.omit()

# taking a look
glimpse(rd)

# Here we have three treatment groups:

# The control is exposed to several placebo facebook articles on non-political issues
# The one-sided treatment is exposed to the placebo articles as well as criticism of Vladimir Putin
# The balanced treatment is exposed to the placebo articles, criticsm of Vladimir Putin, and a post criticising corruption in the United States

# Does balanced criticism (presenting criticism of one's own country) increase the persuasivness of criticism targeting a country's leader?
plot_frq(rd$foreign_treat)

#More regime supporers (coded as people who voted for Putin in 2018)
plot_frq(rd$regimesupport)

#Skew in education (most Russians have completed many years of schooling)
plot_frq(rd$education, type = "hist", show.mean = TRUE)

#Age looks fine
plot_frq(rd$age, type = "hist", show.mean = TRUE)

#Skew in political interest given the survey is on an online sample that was recurited to be intrested in politics
plot_frq(rd$polinterest4, type = "hist", show.mean = TRUE)

#Plot of Dependent Variable (Support for Putin), ranges from 0 to 1
plot_frq(rd$putin, type = "hist", show.mean = TRUE)

#Plot of whether people think democracy is functioning in Russia
plot_frq(rd$democracy, type = "hist", show.mean = TRUE)

# re-code religion variable
rd$howreligious<-as.numeric(rd$howreligious)
glimpse(rd)

# individuals who took proper amount of time to take survey
rd2 <-  rd  %>%
  filter(pass==1)

# four different models
m1 <- lm(as.numeric(putin) ~ foreign_treat, data = rd)
m2 <- lm(as.numeric(putin) ~ foreign_treat +  + female + married + 
           city + age + russian + regimesupport + howreligious +
           orthodox + education + polinterest4 + media_use3 +
           mediachoice + usattitudes + socialmediause, data = rd)
m3 <- lm(as.numeric(putin) ~ foreign_treat, data = rd2)
m4 <- lm(as.numeric(putin) ~ foreign_treat + female + married + 
           city + age + russian + regimesupport + howreligious +
           orthodox + education + polinterest4 + media_use3 +
           mediachoice + usattitudes + socialmediause, data = rd2)


# transform model objects into data frames, 
# using tidy can be helpful when one wishes 
# to omit certain model estimates from the plot. 

m1_tidy <- tidy(m1) 
m1_tidy <- m1_tidy %>% 
  mutate(model = "Full")

m2_tidy <- tidy(m2)
m2_tidy <- m2_tidy %>% 
  mutate(model = "Full+Controls")

m3_tidy <- tidy(m3) 
m3_tidy <- m3_tidy %>% 
  mutate(model = "Screen")

m4_tidy <- tidy(m4) 
m4_tidy <- m4_tidy %>% 
  mutate(model = "Screen+Controls")

# "glue" model data frames together
all_models <- bind_rows(m1_tidy, m2_tidy, m3_tidy, m4_tidy)

# dwplot with all variables
dwplot(all_models,
       vline = geom_vline(xintercept = 0, colour = "grey60", linetype = 2)) +
  theme_bw() + xlab("Coefficient Estimate") + ylab("") +
  geom_vline(xintercept = 0, colour = "grey60", linetype = 2) +
  ggtitle("Treatments Effect on Support for Putin") +
  theme(plot.title = element_text(face="bold"),
        legend.position = c(0.80, 0.71),
        legend.justification = c(0, 0), 
        legend.background = element_rect(colour="grey80"),
        legend.title = element_blank()) +
  scale_y_discrete(labels=c('Social Media Use', 'Favorable U.S.', 'Neutral U.S.', 
                            'Media Optimistic', 'Foregn Media Trust', 'Domestic Media Trust', 
                            'Internet User', 'Political Interest', 'Education', 'Orthodox', 
                            'Religiosity', 'Regime Supporter', 'Opposition Voter', 
                            'Ethnic Russian', 'Age', 'Urban', 'Married', 'Female', 
                            'Balanced Criticism', 'One-Sided Criticism'))

# only include treatments
all_models2 <- all_models%>% 
  filter(grepl("foreign_treat", term))

# dwplot with only treatments
dwplot(all_models2,
       vline = geom_vline(xintercept = 0, colour = "grey10", linetype = 2),
       dot_args = list(aes(shape = model), size=3),
       whisker_args = list(aes(linetype = model), size=0.8)) +
  theme_bw() + xlab("Coefficient Estimate") + ylab("")+
  guides(col = guide_legend(nrow=4))+
  ggtitle("Treatments Effect on Support for Putin") +
  theme(plot.title = element_text(face="bold", hjust=0.5),
        legend.position = c(0.82, 0.01),
        legend.justification = c(0, 0), 
        legend.background = element_rect(colour="grey80"),
        strip.background = element_blank(),
        panel.grid.minor.y = element_blank(), 
        panel.grid.major.x = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        legend.title = element_blank()) +
  scale_y_discrete(labels = c('Balanced Criticism','One-sided Criticism')) +
  scale_colour_grey()+
  scale_x_continuous(limits = c(-0.2, 0.2))

###############################
#Examining interaction Effects#
###############################

# Does the treatment effect vary by Regime Support
# fit model with interaction - Putin (DV)
fit_putin <- lm(putin ~ foreign_treat*regimesupport, data = rd2)
plot_model(fit_putin, type = "pred", terms = c("foreign_treat", "regimesupport")) +
  ggtitle("Treatment Effects on Support for for Vladimir Putin") +
  theme_bw() + xlab("Treatments") + ylab("Support for Putin")



# fit model with interaction - Democracy (DV)
fit_dem <- lm(democracy~ foreign_treat*regimesupport, data = rd2)
plot_model(fit_dem, type = "pred", terms = c("foreign_treat", "regimesupport")) +
  ggtitle("Treatment Effects on  Attitudes toward Democracy") +
  theme_bw() + xlab("Treatments") + ylab("Russia is Democratic")

# fit model with 3-way-interaction - Education
fit <- lm(putin ~ education * foreign_treat * regimesupport, data = rd2) 
plot_model(fit, type = "pred", terms = c("education [1,5,11]", "foreign_treat" , "regimesupport")) +
  ggtitle("Treatment Effects on Support for Vladimir Putin") +
  theme_bw() + xlab("Education") + ylab("Support for Putin")

#Just Education and Treatment Interaction
m_putin <- lm(putin ~ education * foreign_treat, data = rd)
plot_model(m_putin, type = "pred", terms = c("education", "foreign_treat"))

###########
#Interplot#
###########

library(interplot)

interplot(m = m_putin, var1 = "foreign_treat", var2 = "education", hist=T) +
  # Add labels for X and Y axes
  xlab("Education") +
  ylab("Treatment Effect") +
  # Change the background
  theme_bw() +
  # Add the title
  ggtitle("Estimated Treatment Effect of Criticism of Vladimir Putin \nby Education") +
  theme(plot.title = element_text(face="bold")) +
  # Add a horizontal line at y = 0
  geom_hline(yintercept = 0, linetype = "dashed")


m_putin2 <- lm(putin ~ age * foreign_treat, data = rd)
summary(m_putin2)

interplot(m = m_putin2, var1 = "foreign_treat", var2 = "age", hist=T) +
  # Add labels for X and Y axes
  xlab("Age") +
  ylab("Treatment Effect") +
  # Change the background
  theme_bw() +
  # Add the title
  ggtitle("Estimated Treatment Effect of Criticism of Vladimir Putin \nby Education") +
  theme(plot.title = element_text(face="bold")) +
  # Add a horizontal line at y = 0
  geom_hline(yintercept = 0, linetype = "dashed")

# coursera - data science - michigan
# Andrew ng - coursera - machine learning
# khan academy 


#TPE GRAPHS

rm(list = ls()) 

library(foreign)
library(tibble)
library(dotwhisker)
library(broom)
library(dplyr)
library(sjPlot)
library(sjmisc)
library(ggplot2)
library(sjlabelled)

tpe<- read.dta("TPE.dta") 
tpe <- tpe %>%
  filter(screen==1)

#Loading Data
tpe<- 
  tpe %>%
  select(treatments,
         illegitimate, ban, propother, propself, female, gen3, white, educ,
         party538, aware2, polinterest, trust_media) %>% 
  na.omit()

