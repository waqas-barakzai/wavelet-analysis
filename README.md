# Wavelet Analysis of Time-Series Variables

## Overview

This repository contains R code for conducting **wavelet-based time-series analysis** using wavelet coherence and wavelet reconstruction methods.

The analysis is designed to investigate relationships, frequency patterns, and trends between two time-series variables over the period **2004–2023**.

The code is organized into three main analytical stages:

1. **Wavelet Coherence Analysis** — examines the relationship between variables A and B.
2. **Wavelet Reconstruction** — reconstructs variable A to identify trends and underlying components.
3. **Power Spectrum / Coherence Analysis** — compares the original and reconstructed versions of variable A.

---

## Data

The analysis requires a dataset named:

```text
All_Data_Ready_for_analysis
```

The dataset should contain, at minimum, the following variables:

* `A` — first time-series variable
* `B` — second time-series variable

The analysis uses **480 observations**, corresponding to the period:

**2004–2023**

The time index is constructed as:

```r
1:480
```

---

## Required R Packages

The following R packages are used:

```r
install.packages("readxl")

library(biwavelet)
library(WaveletComp)
library(fields)
```

### Main Packages

**`biwavelet`**

Used to perform wavelet coherence analysis and generate wavelet coherence plots.

**`WaveletComp`**

Used for wavelet analysis and reconstruction of the time series.

**`fields`**

Used as a supporting package for the analysis.

**`readxl`**

Used for importing Excel datasets when required.

---

# 1. Wavelet Coherence: A vs B

The first section examines the relationship between variables A and B.

```r
library(biwavelet)

attach(All_Data_Ready_for_analysis)

t1 = cbind(1:480, A)
t2 = cbind(1:480, B)

wtc.AB = wtc(t1, t2, nrands = 20)

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

n = length(t1[, 1])

axis(
    side = 1,
    at = seq(24, n, by = 24),
    labels = seq(2004, 2023, 1)
)
```

The `wtc()` function calculates **wavelet coherence** between A and B.

The analysis uses:

```r
nrands = 20
```

randomizations to assess the statistical significance of the wavelet coherence results.

### Objective

This section is designed to identify:

* Common cyclical patterns between A and B
* Periods of strong coherence
* The direction and phase relationship between the variables
* Statistically significant areas of coherence
* Changes in the relationship across different time scales

Phase arrows are enabled using:

```r
plot.phase = TRUE
```

---

# 2. Reconstruction of Variable A

The second section applies wavelet analysis to variable A and reconstructs its wavelet components.

```r
library("WaveletComp")
library("fields")

my.w <- analyze.wavelet(
    All_Data_Ready_for_analysis,
    "A",
    loess.span = 0,
    dt = 0.25,
    dj = 1/250,
    make.pval = TRUE,
    n.sim = 30
)

my.rec <- reconstruct(
    my.w,
    plot.waves = FALSE,
    lwd = c(1, 2),
    legend.coords = "bottomleft",
    ylim = c(Min = 9.21, Max = 16.71)
)
```

The `analyze.wavelet()` function performs the wavelet analysis on variable A.

### Main Parameters

| Parameter    |   Value | Description           |
| ------------ | ------: | --------------------- |
| `loess.span` |     `0` | No LOESS smoothing    |
| `dt`         |  `0.25` | Time step             |
| `dj`         | `1/250` | Scale resolution      |
| `make.pval`  |  `TRUE` | Calculates p-values   |
| `n.sim`      |    `30` | Number of simulations |

The reconstructed series is obtained using the `reconstruct()` function.

Wavelet reconstruction allows the analysis to recover components of the original time series and examine its underlying time-frequency structure.

---

# 3. Power Spectrum / Original vs Reconstructed A

The third section compares the original A series with its reconstructed component.

First, the reconstructed series is extracted:

```r
library(biwavelet)

attach(my.rec[["series"]])

t1 = cbind(1:480, A)
t2 = cbind(1:480, A.r)

wtc.AB = wtc(t1, t2, nrands = 20)
```

The resulting wavelet coherence plot is generated without phase arrows:

```r
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

n = length(t1[, 1])

axis(
    side = 1,
    at = c(seq(1, n, 24)),
    labels = c(seq(2004, 2023, 1))
)
```

### Objective

This stage evaluates how closely the reconstructed version of A corresponds to the original series across different time-frequency domains.

---

# Analysis Workflow

The overall analytical workflow is:

```text
Prepared Dataset
       │
       ▼
Variables A and B
       │
       ├──────────────► Wavelet Coherence
       │                       │
       │                       ▼
       │                 A–B Relationship
       │
       ▼
Wavelet Analysis of A
       │
       ▼
Wavelet Reconstruction
       │
       ▼
Reconstructed A
       │
       ▼
Comparison with Original A
       │
       ▼
Wavelet Coherence / Power Spectrum
```

---

# Data Requirements

Before running the analysis, make sure that:

* The dataset is available in R.
* The dataset contains variables **A** and **B**.
* There are **480 observations**.
* The observations correspond to the period **2004–2023**.
* The variables are appropriately prepared for wavelet analysis.

---

# Reproducibility

To reproduce the analysis:

1. Install R and RStudio.
2. Install the required R packages.
3. Load the dataset.
4. Ensure that variables A and B are available.
5. Run the wavelet coherence analysis.
6. Run the wavelet reconstruction.
7. Run the comparison between the original and reconstructed A series.
8. Examine the resulting wavelet plots.

---

# Notes

* The analysis assumes **480 observations**.
* The time period covered is **2004–2023**.
* Variable names used in the analysis are `A` and `B`.
* The number of random simulations can be increased for more robust statistical inference, although this may increase computation time.
* The `attach()` function is used in the original workflow. For larger or more reproducible projects, explicit dataset references are generally recommended.

---

# Repository Structure

A possible repository structure is:

```text
wavelet-analysis/
│
├── README.md
├── analysis.R
├── data/
│   └── dataset.xlsx
└── results/
    └── figures/
```

---

# Purpose

This repository provides a reproducible implementation of **wavelet coherence and wavelet reconstruction techniques** for analyzing the dynamic relationship between two time-series variables.

The approach focuses on identifying relationships that may vary across both **time** and **frequency**, providing a time-frequency perspective that conventional correlation analysis may not capture.

---

# License

MIT License

Copyright (c) 2026 [Muhammad Waqas Khalid]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
