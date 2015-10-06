# getReturns.r
# 
# Functions for computing returns
# last updated: November 18, 2012 by Wilson Freitas
#
# Functions:
#	1. getReturnsFromYahooFiles			compute returns for Adjusted Closing Prices
#							            of financial time series downloaded from
#                                       Yahoo! Finance web site
#

suppressPackageStartupMessages(library(xts))

read.yahoo <-
function(filelist, ...) {
    
}

returns.methods <- list(
    simple=function( x ) diff(x)/lag(x, k=-1),
    compound=function( x ) diff(log(x))
)

getReturnsFromYahooFiles <-
function(filelist, method="compound", frequency="monthly", 
    date.format="%Y-%m-%d") {
    
    count <- 0
    for ( fname in filelist ) {
        count <- count + 1
        fs.split <- unlist(strsplit(fname, "/"))
        id <- unlist(strsplit(fs.split[length(fs.split)], "\\."))[1]
        series.df <- read.csv(fname, header=TRUE, stringsAsFactors=FALSE, 
            row.names=1)
        row.names(series.df) <- as.Date(row.names(series.df), 
            format=date.format)
        series.df <- series.df[order(row.names(series.df)),]
        prices.df <- series.df[, "Adj.Close", drop=FALSE]
        if (frequency == "monthly") {
            aux.x <- xts(x=prices.df[, 1], 
                order.by=as.yearmon(row.names(prices.df), format="%Y-%m-%d"))
        } else if (frequency == "daily") {
            aux.x <- xts(x=prices.df[, 1], 
                order.by=as.Date(row.names(prices.df)))
        }
        colnames(aux.x) <- id

        if ( !is.null(returns.methods[[method]]) ) {
            retaux.x <- returns.methods[[method]](aux.x)
        } else {
            # TODO  raise unkown method exception
            # Error: unknown method
        }

        if ( count == 1 ) {
            ret.x <- retaux.x
        } else {
            ret.x <- merge(ret.x, retaux.x)
        }
    }
    n <- dim(ret.x)[1]
    ret.x[2:n,]
}

