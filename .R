------------------------------------------------------------------------------------------------------
#RECONSTRUCTION OF VARIABLES - NEW TRENDS - success code
library("WaveletComp")
library("fields")
my.w <- analyze.wavelet(All_Data_Ready_for_analysis, "lnco2i",loess.span = 0,dt = 0.25, dj = 1/250,make.pval = TRUE, n.sim = 30)
my.rec <- reconstruct(my.w, plot.waves = FALSE, lwd = c(1,2), legend.coords = "bottomleft", ylim = c(Min=9.21, Max=16.71))


------------------------------------------------------------------------------------------------
  #POWER SPECTURM - success code
  
library(biwavelet) 
attach (my.rec[["series"]])
A=co2.rec
B=co2.r
t1 = cbind(1:480, co2) 
t2 = cbind(1:480, co2.r) 
wtc.AB = wtc(t1, t2, nrands = 20) 
par(oma = c(0, 0, 0, 1), mar = c(5, 4, 4, 5) + 0.1) 
plot(wtc.AB, plot.phase = FALSE, lty.coi = 1, col.coi = "grey", lwd.coi = 2, lwd.sig = 2, arrow.lwd = 0.03, arrow.len = 0.12, ylab = "Scale", xlab = "Period", plot.cb = TRUE, main = "Industrial CO2 Emissions", xaxt="n")
n = length(t1[, 1])
axis(side = 1, at = c(seq(1, n, 24)), labels = c(seq(2004, 2023, 1)))

------------------------------------------------------------------------------------------------------
#wavelet coherence pairs - success coding
  install.packages("readxl")
library(biwavelet)
attach(All_Data_Ready_for_analysis)

A=co2  
B=gdp
t1 = cbind(1:480, co2)
t2 = cbind(1:480, gdp)
wtc.AB = wtc(t1, t2, nrands = 20)
par(oma = c(0, 0, 0, 1), mar = c(5, 4, 4, 5) + 0.1)
plot(wtc.AB, plot.phase = TRUE, lty.coi = 1, col.coi = "grey", lwd.coi = 2, 
     lwd.sig = 2, arrow.lwd = 0.03, arrow.len = 0.12, ylab = "Scale", xlab = "Period", 
     plot.cb = TRUE, main = "a. CO2 emissions vs Artificial Intelligence", xaxt="n")
n = length(t1[, 1])
axis(side = 1, at = seq(24, n, by = 24), labels = seq(2004, 2023, 1))
