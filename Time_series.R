#Szeregi czasowe#
#Wojciech Rolewski#


install.packages("forecast")
install.packages("expsmooth")
library(dplyr)
library(expsmooth) 
library(forecast)
library(tseries)

#Wczytywanie danych

elektrycznosc<-read.csv(file = "E:/IAD/Szeregi_czasowe/electricity.csv")
napoje<-read.csv(file = "E:/IAD/Szeregi_czasowe/drinks.csv")

elektrycznosc1 <- ts(elektrycznosc$APU000072610, start = c(2015,1),end=c(2022,4), frequency = 12)
napoje1 <- ts(napoje$APU0000FN1101, start = c(2018,4), frequency = 12)

#Wykresy
plot(elektrycznosc1, main="Cena pr¹du",ylab="Dolar/KWH",xlab="Lata")
plot(napoje1, main="Cena napojów",ylab="Dolar/2L",xlab="Lata")

monthplot(elektrycznosc1, main="Cena pr¹du",ylab="Dolar/KWH",xlab="Miesi¹ce")
monthplot(napoje1, main="Cena napojów",ylab="Dolar/2L",xlab="Miesi¹ce")

boxplot(elektrycznosc1, main="Cena pr¹du",ylab="Dolar/KWH")
boxplot(napoje1, main="Cena napojów",ylab="Dolar/2L")

seasonplot(elektrycznosc1,col = rainbow(12), year.labels = TRUE, pch = 19,main="Cena pr¹du",ylab="Dolar/KWH",xlab="Miesi¹ce")
seasonplot(napoje1,col = rainbow(12), year.labels = TRUE, pch = 19,main="Cena napojów",ylab="Dolar/2L",xlab="Miesi¹ce")

lag.plot(elektrycznosc1, lags=12, do.lines = FALSE,main="Cena pr¹du") 
lag.plot(napoje1, lags=12, do.lines = FALSE,main="Cena napojów")

tsdisplay(elektrycznosc1,main="Cena pr¹du",ylab="Dolar/KWH",xlab="Lata")
tsdisplay(napoje1,main="Cena napojów",ylab="Dolar/2L",xlab="Lata")

acf(elektrycznosc1,main="Autokorelacja [pr¹d]")
acf(napoje1,main="Autokorelacja [napoje]")

pacf(elektrycznosc1,lag.max=100,main="Czêœciowa autokorelacja")
pacf(napoje1, lag.max=100,main="Czêœciowa autokorelacja")
pacf(elektrycznosc1,main="Czêœciowa autokorelacja [pr¹d]")
pacf(napoje1,main="Czêœciowa autokorelacja [napoje]")

#dekompozycja

dm_elektrycznosc <- decompose(elektrycznosc1, type = "multiplicative")
plot(dm_elektrycznosc)
tsdisplay(dm_elektrycznosc$random)
#Sprawdzanie czy szereg jest sezonowy 
tsdisplay(dm_elektrycznosc$seasonal)

da_elektrycznosc <- decompose(elektrycznosc1, type = "additive")
plot(da_elektrycznosc)
plot(da_elektrycznosc$trend)

dm_napoje <- decompose(napoje1, type = "multiplicative")
plot(dm_napoje)
tsdisplay(dm_napoje$random)
tsdisplay(dm_napoje$seasonal)
da_napoje <- decompose(napoje1, type = "additive")
plot(da_napoje)
plot(da_napoje$trend)

#eliminacja trendu i sezonowosci

t_elektrycznosc<-diff(elektrycznosc1)#eliminacja trendu
tsdisplay(t_elektrycznosc)
t_napoje<-diff(napoje1)
tsdisplay(t_napoje)

s_elektrycznosc <- diff(elektrycznosc1, lag = 12) #bez sezonowoÅ›ci
tsdisplay(s_elektrycznosc)
s_napoje <- diff(napoje1, lag = 12)
tsdisplay(s_napoje)

ts_elektrycznosc <- diff(t_elektrycznosc, lag = 12) #bez trendu i sezonowoÅ›ci
tsdisplay(ts_elektrycznosc)
ts_napoje <- diff(t_napoje, lag = 12) #bez trendu i sezonowoÅ›ci
tsdisplay(ts_napoje)

#uczynienie szeregow stacjonarnymi
plot(elektrycznosc1)
tsdisplay(elektrycznosc1)
bc_elektrycznosc<-BoxCox(elektrycznosc1,lambda=0)
elektrycznosc2<-diff(bc_elektrycznosc,lag=12)
tsdisplay(elektrycznosc2)
elektrycznosc3<-diff(elektrycznosc2,lag=1)
tsdisplay(elektrycznosc3)
#sprawdzenie czy jest realizacj¹ modelu szumu bialego
Acf(elektrycznosc3, lag.max=100)#wartosci wystaj¹ poza przedzia³ ufnoœci, wiêc szereg nie jest realizacja SB

plot(napoje1)
tsdisplay(napoje1)
bc_napoje<-BoxCox(napoje1,lambda=0)
napoje2<-diff(bc_napoje,lag=12)
tsdisplay(napoje2)
napoje3<-diff(napoje2,lag=1)
tsdisplay(napoje3)


Acf(elektrycznosc3, lag.max=100)
Pacf(elektrycznosc3,lag.max=40) #q=12

Acf(napoje3, lag.max=100)
Pacf(napoje3,lag.max=60)

#wyznaczanie wspolczynnikow modelu AR
elektrycznosc_ar1 <- ar(elektrycznosc3, aic = TRUE, order.max = 74, method = c("yule-walker"))
print(elektrycznosc_ar1)
elektrycznosc_ar2 <- ar(elektrycznosc3, aic = TRUE, order.max = 20, method = c("mle"))
print(elektrycznosc_ar2)


napoje_ar1 <- ar(napoje3, aic = TRUE, order.max = 35, method = c("yule-walker"))
str(napoje_ar1)
print(napoje_ar1)
napoje_ar2 <- ar(napoje3, aic = TRUE, order.max = 10, method = c("mle"))
str(napoje_ar2)
print(napoje_ar2)

#wyznaczenie wspó³czynnika modeli MA(q)

elektrycznosc_ma <- Arima(elektrycznosc1, order = c(0,0,17)) 
summary(elektrycznosc_ma)

napoje_ma <- Arima(napoje1, order = c(0,0,12))
summary(napoje_ma)

#wyznaczanie optymalnych modeli

(elektrycznosc_aicc <- auto.arima(elektrycznosc3, ic = "aicc"))
(elektrycznosc_aic <- auto.arima(elektrycznosc3, ic = "aic"))
(elektrycznosc_bic <- auto.arima(elektrycznosc3, ic = "bic"))


(napoje_aicc <- auto.arima(napoje3, ic = "aicc"))
(napoje_aic <- auto.arima(napoje3, ic = "aic"))
(napoje_bic <- auto.arima(napoje3, ic = "bic"))

#Porownanie analizowanych modeli
summary(elektrycznosc_ma)
summary(elektrycznosc_aicc)
summary(elektrycznosc_aic)
summary(elektrycznosc_bic)

summary(napoje_ma)
summary(napoje_aicc)
summary(napoje_aic)
summary(napoje_bic)

#Prognozowanie

#srednia 
sr1 <- meanf(elektrycznosc1,h =12)
plot(sr1, main = "Prognoza na podstawie œredniej")

sr2 <- meanf(napoje1,12)
plot(sr2, main = "Prognoza na podstawie œredniej")

#naiwna 
n1 <- naive(elektrycznosc1, h=12)
plot(n1, main = "Metoda Naiwna")
ns1 <- snaive(elektrycznosc1, h=12)
plot(ns1, main = "Metoda Naiwna Sezonowa")#najlepsza

n2 <- naive(napoje1, h=12)
plot(n2, main = "Metoda Naiwna")
ns2 <- snaive(napoje1, h=12)
plot(n2, main = "Metoda Naiwna Sezonowa")


#Dryf 
d1 <- rwf(elektrycznosc1, drift = TRUE, h=12)
plot(d1, main = "Metoda uwzglêdniaj¹ca dryf")

d2 <- rwf(napoje1, drift = TRUE, h=12)
plot(d2, main = "Metoda uwzglêdniaj¹ca dryf")#najlepsza
