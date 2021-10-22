#adatok formázása
df <- read.csv("adatb_tisztitott.csv",sep=";", encoding = "UTF-8", stringsAsFactors=FALSE)
library(tidyverse)
library(janitor)
library(stats)
library(car)
library(GGally)
library(corpcor)
library(sandwich)
library(lmtest)
library(olsrr)

names(df)[1]<- "Telepules"

df <- df %>% 
  drop_na() %>% 
  clean_names()
  
df<- filter(df, ing_allapota!="bontásra")
df <- filter(df, telepules!= "Vir")
df <- filter(df, telepules!= "Novalja")

df$lift<- ifelse(df$lift=="igen" | df$lift=="van", 1, 0)
df$lift <- factor(df$lift, levels = c("1", "0"), labels = c("1", "0"))

df$ing_allapota <- factor(df$ing_allapota, 
                             levels = c("felújítandó", "építés alatt",
  "közepes állapotú","felújított","jó állapotú", "újszerű", "új építésű")) 

table(df$ing_allapota)

df$epites_tipusa <- factor(df$epites_tipusa, levels=c("panel", "egyéb", "tégla"),
                           labels = c("0", "1", "2"))

df$terulet_m_2 <- as.integer(df$terulet_m_2)
df$ar_e_ft <- as.double(df$ar_e_ft)

df$futes <- fct_collapse (df$futes,
  villany ="villany",
  tavfutes = "távfűtés",
  kozponti = "központi",
  gaz = c("gáz", "gáz (cirko)", "gáz (konvektor)"),
  egyeb = "egyéb")

df$regio <- fct_collapse(df$megye,
    Del_Alfold = c("Bács-Kiskun", "Békés", "Csongrád"),
    Del_Dunantul = c( "Baranya", "Somogy"),
    Eszak_Alfold = c("Hajdú-Bihar", "Jász-Budapestgykun-Szolnok", "Szabolcs-Szatmár-Bereg"),
    Eszak_Magyarorszag = c("Borsod-Abaúj-Zemplén", "Nógrád"),
    Kozep_Dunantul = c("Fejér", "Komárom-Esztergom","Veszprém"),
    Nyugat_Dunantul = c("Gyor-Moson-Sopron","Vas", "Zala"),
    Pest="Pest",
    Budapest="Budapest")



#szamolasok


#regresszio
model_0 <- lm (data = df, formula = ar_e_ft ~ terulet_m_2 + epites_tipusa +
                  futes + emelet + ing_allapota + lift + egesz_szoba + felszobak_szama + regio)


anova<- aov(data = df, formula = ar_e_ft ~ terulet_m_2 + epites_tipusa +
  futes + emelet + ing_allapota + lift + egesz_szoba + felszobak_szama + regio)

summary(anova)
summary(model_0)


X<- df[, c(2,3,5:9, 11,12,13)]
pairs(X, pch = 18, col = "steelblue")

#vif
vif(model_0)




#ggpairs(X)

cor2pcor(cov(X))

# Modellspecifikáció teszt 
?resettest
resettest(model_0, power = 2:3, type = "regressor", data = df)

#heteroszked

uhat2 <- model_0$residuals^2
y <- fitted(model_0)
bptest(uhat2 ~ y + I(y^2))
par(mfrow=c(2,2))
plot(model_0)


bptest(model_0)
ncvTest(model_0)
ols_test_breusch_pagan(model_0)
#var.func <- lm(uhat^2 ~ terulet_m_2 + epites_tipusa +
                 #futes + emelet + ing_allapota + lift + egesz_szoba + felszobak_szama + regio, data = df)
#summary(var.func)                            nem biztos hogy kellenek


coeftest(model_0, vcov. = vcovHC(model_0, "HC1")) 



#modellszelekció

?waldtest
model_1 <- lm (data = df, formula = ar_e_ft ~ terulet_m_2 + epites_tipusa +
                 futes +  ing_allapota + lift + egesz_szoba + regio+ felszobak_szama)
waldtest(model_0, model_1)
summary(model_1)
coeftest(model_1, vcov. = vcovHC(model_0, "HC1"))






