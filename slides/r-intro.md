---

title       : R intro  
subtitle    : deeply based on vignette source 'RIntro.Rnw'  
author      : Wilson Freitas  
job         : Quant  
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}  
highlighter : highlight.js  # {highlight.js, prettify, highlight}  
hitheme     : tomorrow      #   
widgets     : []            # {mathjax, quiz, bootstrap}  
mode        : selfcontained # {standalone, draft, selfcontained}  

---

## Define where you are about to work


```r
> getwd()
```

```
## [1] "/Users/wilson"
```

```r
> setwd("/Users/wilson/Google Drive/dev/trading-strategies/slides")
> getwd()
```

```
## [1] "/Users/wilson/Google Drive/dev/trading-strategies/slides"
```


---

## Creating `numeric` variables


```r
> y <- 5  # y = 5 also work but <- is R stylish
> y
```

```
## [1] 5
```

```r
> class(y)
```

```
## [1] "numeric"
```


---

## Creating `numeric` vectors


```r
> x <- c(3.1416, 2.7183, 1, 3)
> x
```

```
## [1] 3.142 2.718 1.000 3.000
```

```r
> x[2]  # indexing
```

```
## [1] 2.718
```

```r
> class(x)
```

```
## [1] "numeric"
```


---

## Creating `matrix` variables


```r
> m <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)
> m
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

```r
> class(m)
```

```
## [1] "matrix"
```


---

## Creating `data.frame` variables


```r
> tab <- data.frame(store = c("downtown", "eastside", "airport"), sales = c(32, 
+     17, 24))
> tab
```

```
##      store sales
## 1 downtown    32
## 2 eastside    17
## 3  airport    24
```

```r
> class(tab)
```

```
## [1] "data.frame"
```


---

## Creating string vectors (`character` type)


```r
cities <- c("Seattle", "Portland", "San Francisco")
cities
```

```
## [1] "Seattle"       "Portland"      "San Francisco"
```

```r
class(cities)
```

```
## [1] "character"
```



---

## Checking who is out there


```r
> ls()  # list variables in workspace (memory)
```

```
## [1] "cities" "f"      "m"      "tab"    "x"      "y"
```

```r
> # cleaning up memory
> rm(list = ls())
> ls()
```

```
## character(0)
```


---

## vectorized operations


```r
> constants <- c(3.1416, 2.7183, 1.4142, 1.618)
> names(constants) <- c("pi", "euler", "sqrt2", "golden")  # naming vector elements
> constants
```

```
##     pi  euler  sqrt2 golden 
##  3.142  2.718  1.414  1.618
```

```r
> constants^2  # squaring all elements
```

```
##     pi  euler  sqrt2 golden 
##  9.870  7.389  2.000  2.618
```


--- &smaller

## vector indexing


```r
> c(constants[c(1, 3, 4)], constants[c(-1, -2)])
```

```
##     pi  sqrt2 golden  sqrt2 golden 
##  3.142  1.414  1.618  1.414  1.618
```

```r
> constants[c("pi", "golden")]
```

```
##     pi golden 
##  3.142  1.618
```

```r
> constants > 2
```

```
##     pi  euler  sqrt2 golden 
##   TRUE   TRUE  FALSE  FALSE
```

```r
> constants[constants > 2]
```

```
##    pi euler 
## 3.142 2.718
```


--- &smaller

## recycling rule


```r
> constants
```

```
##     pi  euler  sqrt2 golden 
##  3.142  2.718  1.414  1.618
```

```r
> constants * 2
```

```
##     pi  euler  sqrt2 golden 
##  6.283  5.437  2.828  3.236
```

```r
> constants * c(0, 1)
```

```
##     pi  euler  sqrt2 golden 
##  0.000  2.718  0.000  1.618
```

```r
> constants * c(0, 1, 2)
```

```
## Warning: longer object length is not a multiple of shorter object length
```

```
##     pi  euler  sqrt2 golden 
##  0.000  2.718  2.828  0.000
```


--- &smaller

## sequences


```r
> 1:5
```

```
## [1] 1 2 3 4 5
```

```r
> -5:5
```

```
##  [1] -5 -4 -3 -2 -1  0  1  2  3  4  5
```

```r
> seq(from = 0, to = 1, len = 5)
```

```
## [1] 0.00 0.25 0.50 0.75 1.00
```

```r
> seq(from = 0, to = 20, by = 2.5)
```

```
## [1]  0.0  2.5  5.0  7.5 10.0 12.5 15.0 17.5 20.0
```


--- &smaller

## sequences


```r
> seq(0, 10, 2)
```

```
## [1]  0  2  4  6  8 10
```

```r
> seq(by = 2, 0, 10)
```

```
## [1]  0  2  4  6  8 10
```

```r
> seq(0, 10, len = 5)
```

```
## [1]  0.0  2.5  5.0  7.5 10.0
```

```r
> seq(0, 10)
```

```
##  [1]  0  1  2  3  4  5  6  7  8  9 10
```


--- &smaller

## `rep` function


```r
> rep(0, 10)  # initialize a vector
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0
```

```r
> rep(1:4, 2)  # repeat pattern 2 times
```

```
## [1] 1 2 3 4 1 2 3 4
```

```r
> rep(1:4, each = 2)  # repeat each element 2 times
```

```
## [1] 1 1 2 2 3 3 4 4
```

```r
> rep(1:4, c(2, 1, 2, 1))
```

```
## [1] 1 1 2 3 3 4
```

```r
> rep(1:4, each = 2, len = 10)  # 8 integers plus two recycled 1's.
```

```
##  [1] 1 1 2 2 3 3 4 4 1 1
```

```r
> rep(1:4, each = 2, times = 3)  # length 24, 3 complete replications
```

```
##  [1] 1 1 2 2 3 3 4 4 1 1 2 2 3 3 4 4 1 1 2 2 3 3 4 4
```

