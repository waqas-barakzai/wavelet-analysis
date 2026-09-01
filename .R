```r
# ------------------------------------------------------------
# RECONSTRUCTION OF VARIABLE A - NEW TRENDS
# ------------------------------------------------------------

library(WaveletComp)
library(fields)

# Assign the variable to A
A <- All_Data_Ready_for_analysis[[1]]

# Wavelet analysis
my.w <- analyze.wavelet(
  data.frame(A = A),
  "A",
  loess.span = 0,
  dt = 0.25,
  dj = 1/250,
  make.pval = TRUE,
  n.sim = 30
)

# Reconstruction
my.rec <- reconstruct(
  my.w,
  plot.waves = FALSE,
  lwd = c(1, 2),
  legend.coords = "bottomleft",
  ylim = c(Min = 9.21, Max = 16.71)
)


# ------------------------------------------------------------
# POWER SPECTRUM
# ------------------------------------------------------------

library(biwavelet)

# Extract reconstructed series
rec.series <- my.rec[["series"]]

A <- rec.series[[1]]
B <- rec.series[[2]]

# Create time-series objects
t1 <- cbind(1:480, A)
t2 <- cbind(1:480, B)

# Wavelet coherence
wtc.AB <- wtc(
  t1,
  t2,
  nrands = 20
)

# Plot
par(
  oma = c(0, 0, 0, 1),
  mar = c(5, 4, 4, 5) + 0.1
)

plot(
  wtc.AB,
  plot.phase = FALSE,
  lty.coi = 1,
  col.coi = "grey",
  lwd.coi = 2,
  lwd.sig = 2,
  arrow.lwd = 0.03,
  arrow.len = 0.12,
  ylab = "Scale",
  xlab = "Period",
  plot.cb = TRUE,
  main = "Variable A",
  xaxt = "n"
)

n <- length(t1[, 1])

axis(
  side = 1,
  at = c(seq(1, n, 24)),
  labels = c(seq(2004, 2023, 1))
)


# ------------------------------------------------------------
# WAVELET COHERENCE PAIR: A vs B
# ------------------------------------------------------------

install.packages("readxl")
library(biwavelet)

# Assign the two variables
A <- All_Data_Ready_for_analysis[[1]]
B <- All_Data_Ready_for_analysis[[2]]

# Create time-series objects
t1 <- cbind(1:480, A)
t2 <- cbind(1:480, B)

# Wavelet coherence
wtc.AB <- wtc(
  t1,
  t2,
  nrands = 20
)

# Plot
par(
  oma = c(0, 0, 0, 1),
  mar = c(5, 4, 4, 5) + 0.1
)

plot(
  wtc.AB,
  plot.phase = TRUE,
  lty.coi = 1,
  col.coi = "grey",
  lwd.coi = 2,
  lwd.sig = 2,
  arrow.lwd = 0.03,
  arrow.len = 0.12,
  ylab = "Scale",
  xlab = "Period",
  plot.cb = TRUE,
  main = "A vs B",
  xaxt = "n"
)

n <- length(t1[, 1])

axis(
  side = 1,
  at = seq(24, n, by = 24),
  labels = seq(2004, 2023, 1)
)
```
