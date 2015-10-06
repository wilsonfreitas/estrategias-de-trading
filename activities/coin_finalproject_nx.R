# finalproject.r
# 
# Script for computing, execute and evaluate pair trading strategies based on
# cointegrated time series
# 
# The GLS and GDX series are analysed.
# This script executes the cointegration analysis for a small period and 
# evaluates the residuals behaviour during the next few days, since 
# cointegration has been detected.
# 
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

# We have to define the window which cointegration tests are executed
# window size
m <- 50
# jump size
s <- 1
# sample size
n <- m - 1

cval <- mackinnon.cval(m - 1)

# Executing cointegration analysis
idx <- seq(1,m)
k <- 200
coin.found <- FALSE
while (! coin.found) {
    lr <- lm(GLS ~ GDX, data=prices.x[idx+k,])
    ur <- ur.df(y=residuals(lr), lags=4, type="none", selectlags="BIC")
    if (ur@teststat <= cval["tau1", "5pct"]) {
        coin.found <- TRUE
    } else {
        k <- k + 1
    }
}

# k <- 172
# lr <- lm(GLS ~ GDX, data=prices.x[idx+k,])
rmse <- sd(residuals(lr))
spread <- 3.00

par(mfrow=c(2,1))
    idx.a <- seq(max(idx+k)+1, max(idx+k)+50)
    idx.n <- c(idx+k, idx.a)
    plot(prices.x[idx.n, 1], type="n", 
        ylim=c(min(prices.x[idx.n,]), max(prices.x[idx.n,])), main="")
    lines(prices.x[idx+k,"GLS"], col="grey")
    lines(prices.x[idx+k,"GDX"], col="grey")
    lines(prices.x[idx.a,"GLS"], col="red")
    lines(prices.x[idx.a,"GDX"], col="red")

    res.x <- xts(residuals(lr), index(prices.x[idx+k,]))
    res.a <- prices.x[idx.a,1] - (coef(lr)[1] + prices.x[idx.a,2] * coef(lr)[2])
    sig.a <- (res.a/rmse > spread) - (res.a/rmse < -spread)
    ret.a <- diff(prices.x[idx.a,1]) - diff(prices.x[idx.a,2]) * coef(lr)[2]
    ret.a <- ret.a * sig.a
    plot(prices.x[idx.n, 1], type="n", 
        ylim=c(min(res.x, res.a/rmse), max(res.x, res.a/rmse)), main="")
    lines(res.x, col="grey")
    lines(res.a/rmse, col="grey3")
    points(ret.a[sig.a != 0,], col="blue3", pch=16, cex=0.7)
    points(sig.a, col="orange3", pch=16, cex=0.5)
    abline(h=0, col="black")
    abline(h=spread, col="green3")
    abline(h=-spread, col="green3")
par(mfrow=c(1,1))

cat("result = ", sum(ret.a, na.rm=TRUE), "\n")

