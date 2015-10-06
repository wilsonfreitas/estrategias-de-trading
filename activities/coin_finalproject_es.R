# finalproject.r
# 
# Script for computing, execute and evaluate pair trading strategies based on
# cointegrated time series
# The GLS and GDX series are analysed.
# This script executes the cointegration analysis for the entire period.
# last updated: December 20, 2012 by Wilson Freitas
#

library(xts)
library(urca)

# computing mackinnon's critical values
mackinnon.cval <- function(n) {
    cval <- c(-3.9001, -3.3377, -3.0462) + c(-10.534, -5.967, -4.069)/n + c(-30.03, -8.98, -5.73)/(n*n)
    cval <- as.data.frame(t(cval))
    colnames(cval) <- c("1pct", "5pct", "10pct")
    rownames(cval) <- c("tau1")
    cval
}

# Loagind time series from CSV files and preprare a time series object 
# containing both series: GDX, GLS
GLS.df <- read.csv("GLS.csv", header=TRUE, stringsAsFactors=FALSE, 
    row.names=1)
GLS.x <- xts(x=GLS.df[, "Adj.Close", drop=FALSE], 
    order.by=as.Date(row.names(GLS.df), 
    format="%d/%m/%Y"))

GDX.df <- read.csv("GDX.csv", header=TRUE, stringsAsFactors=FALSE, 
    row.names=1)
GDX.x <- xts(x=GDX.df[, "Adj.Close", drop=FALSE], 
    order.by=as.Date(row.names(GDX.df),
    format="%d/%m/%Y"))

# using join inner the new time series has the size of the shorter series.
prices.x <- merge(GLS.x, GDX.x, join='inner')
names(prices.x) <- c("GLS", "GDX")

# plotting time series
plot(prices.x[, "GLS"], main="prices", ylim=c(min(prices.x), max(prices.x)))
lines(prices.x[, "GDX"])

cval <- mackinnon.cval(dim(prices.x)[1] - 1)
cval
# evaluating the complete data
lr <- lm(GLS ~ GDX - 1, data=prices.x)
summary(lr)
ur <- ur.df(y=residuals(lr), type="none")
plot(ur)
ur@teststat
ur@teststat <= cval

# evaluating the complete data
lr <- lm(GDX ~ GLS - 1, data=prices.x)
summary(lr)
ur <- ur.df(y=residuals(lr), type="none")
plot(ur)
ur@teststat
ur@teststat <= cval
