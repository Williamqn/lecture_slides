

library(knitr)
opts_chunk$set(prompt=TRUE, tidy=FALSE, strip.white=FALSE, comment=NA, highlight=FALSE, message=FALSE, warning=FALSE, size='scriptsize', fig.width=4, fig.height=4)
options(width=60, dev='pdf')
thm <- knit_theme$get("acid")
knit_theme$set(thm)



x_var <- seq(-2*pi, 2*pi, len=100)  # x values

# open Windows graphics device
x11(width=11, height=7, title="simple plot")

# plot a sine function using basic line plot
plot(x=x_var, y=sin(x_var), xlab="x-val", 
     ylab="y-val", type='l', lwd=2, col="red")
# add a cosine function
lines(x=x_var, y=cos(x_var), lwd=2, col="blue")
# add title
title(main="sine and cosine functions", line=0.1)
# add legend
legend(x="topright", legend=c("sine", "cosine"),
       title="legend", inset=0.1, cex=1.0, bg="white",
       lwd=2, lty=c(1, 1), col=c("red", "blue"))
graphics.off()  # close all graphics devices



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
# plot a Normal probability distribution
curve(expr=dnorm, type="l", xlim=c(-3, 3), 
      xlab="", ylab="", lwd=2, col="blue")
# add shifted Normal probability distribution
curve(expr=dnorm(x, mean=1), add=TRUE, 
      type="l", lwd=2, col="red")

# add title
title(main="Normal probability distribution functions", 
      line=0.1)
# add legend
legend(x="topright", legend=c("Normal", "shifted"),
       title="legend", inset=0.05, cex=0.8, bg="white",
       lwd=2, lty=c(1, 1), col=c("blue", "red"))



par(mar=c(7, 4, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
pois_vector <- rpois(100, 4)  # Poisson numbers
# calculate contingency table
pois_table <- table(pois_vector)
pois_table <- pois_table/sum(pois_table)
pois_table

library(MASS)  # create histogram of Poisson variables
truehist(pois_vector, nbins="FD", col="blue", xlab="No. of events", 
 ylab="Frequency of events", main="Poisson histogram")
x_var <- 0:max(pois_vector)  # add Poisson density
lines(x=x_var, y=dpois(x_var, lambda=4), lwd=4, col="red")
# add legend
legend(x="topright", legend="Poisson density", title="", inset=0.05, 
       cex=0.8, bg="white", lwd=4, lty=1, col="red")



graph_params <- par()  # get existing parameters
par("mar")  # get plot margins
par(mar=c(2, 1, 2, 1))  # set plot margins
par(oma=c(1, 1, 1, 1))  # set outer margins
par(mgp=c(2, 1, 0))  # set title and label margins
par(cex.lab=0.8,  # set font scales
    cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(las=1)  # set axis labels to horizontal
par(ask=TRUE)  # pause, ask before plotting
par(mfrow=c(2, 2))  # plot on 2x2 grid by rows
for (i in 1:4) {  # plot 4 panels
  barplot(sample(1:6), main=paste("panel", i), 
  col=rainbow(6), border=NA, axes=FALSE)
  box()
}
par(ask=FALSE)  # restore automatic plotting
par(new=TRUE)  # allow new plot on same chart
par(graph_params)  # restore original parameters



rm(list=ls())
Sys.Date()  # get today's date
date_time <- as.Date("2013-06-15")  # "%Y-%m-%d" or "%Y/%m/%d"
date_time
class(date_time)
as.Date("06-15-2013", "%m-%d-%Y")  # specify format
date_time + 20  # add 20 days
unclass(date_time)  # get internal integer representation
some.date <- as.Date("11/22/2013", "%m/%d/%Y")
some.date
# difference between dates
difftime(some.date, date_time, units="weeks")
weekdays(date_time)  # get day of the week



par(mar=c(5, 3, 1, 1), oma=c(1, 1, 1, 1), mgp=c(2, 0.5, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
attach(mtcars)  # add mtcars to search path
# specify model of horsepower vs miles per gallon
reg_formula <- mpg ~ hp
# plot scatterplot horsepower vs miles per gallon
plot(reg_formula, 
     main="miles per gallon vs horsepower")
# add labels using wordcloud, to prevent label overlaps
library(wordcloud)
textplot(x=mpg, y=hp, words=rownames(mtcars))

# don't forget to detach!!!
detach(mtcars)



library(zoo)  # load zoo
library(ggplot2)  # load ggplot2
library(scales)  # load scales
my_ggplot <- ggplot(  # specify data and aesthetics
  data=mtcars, mapping=aes(x=hp, y=mpg)) + 
  geom_point() +  # plot points
  ggtitle("basic scatterplot") +  # add title
  theme(  # customize plot object
  plot.title=element_text(vjust=-2.0), 
  plot.background=element_blank()
  )  # end theme
my_ggplot  # render the plot



library(ggplot2)  # load ggplot2
library(scales)  # load scales
library(gridExtra)  # load gridExtra
# coerce mts object into zoo
zoo_series <- as.zoo(EuStockMarkets)
# create ggplot2 theme object
auto_theme <- theme(
  legend.position="none", 
  plot.title=element_text(vjust=-2.0), 
  plot.margin=unit(c(-0.0,0.0,-0.5,0.0),"cm"), 
#  axis.text.y=element_blank(),
  plot.background=element_blank()
  )  # end theme
# ggplot2 object for plotting in single panel
ggp_zoo_single <- autoplot(zoo_series, 
            main="Eu Stox single panel", 
            facets=NULL) + xlab("") +
            auto_theme
# ggplot2 object for plotting in multiple panels
ggp_zoo_multiple <- autoplot(zoo_series, 
            main="Eu Stox multiple panels", 
            facets="Series ~ .") + xlab("") +
            facet_grid("Series ~ .", 
            scales="free_y") + auto_theme
# render plots in single column
grid.arrange(ggp_zoo_single + 
         theme(legend.position=c(0.1, 0.5)), 
       ggp_zoo_multiple, ncol=1)



set.seed(1121)  # for reproducibility
par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
# create monthly time series starting 1990
ts_series <- ts(data=cumsum(rnorm(96)), 
     frequency=12, start=c(1990, 1))
class(ts_series)  # class 'ts'
attributes(ts_series)
methods(class=class(ts_series))[3:8]
# window the time series
window(ts_series, start=1992, end=1992.5)

plot(ts_series, type="l",  # create plot
     col="red", lty="solid", xlab="", ylab="")
title(main="Random Prices", line=-1)  # add title



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
class(EuStockMarkets)  # multiple ts object
dim(EuStockMarkets)
head(EuStockMarkets)  # get first six rows
plot(EuStockMarkets, main="", xlab="")  # plot all the columns
title(main="EuStockMarkets", line=-1)  # add title



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
# calculate DAX percentage returns
dax_rets <- diff(log(EuStockMarkets[, 1]))
# mean and standard deviation of returns
c(mean(dax_rets), sd(dax_rets))
# plot histogram
hist(dax_rets, breaks=30, main="", 
     xlim=c(-0.04, 0.04), ylim=c(0, 60), 
     xlab="", ylab="", freq = FALSE)
# draw kernel density of histogram
lines(density(dax_rets), col='red', lwd=2)
# add density of normal distribution
curve(expr=dnorm(x, mean=mean(dax_rets), sd=sd(dax_rets)), 
      add=TRUE, type="l", lwd=2, col="blue")
title(main="Return distributions", line=0)  # add title
# add legend
legend("topright", inset=0.05, cex=0.8, title=NULL, 
       leg=c(colnames(EuStockMarkets)[1], "Normal"), 
       lwd=2, bg="white", col=c("red", "blue"))



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
# calculate percentage returns
dax_rets <- diff(log(EuStockMarkets[, 1]))
# create normal Q-Q plot
qqnorm(dax_rets, ylim=c(-0.04, 0.04), 
       xlab='Normal Quantiles', main='')
# fit a line to the normal quantiles
qqline(dax_rets, col='red', lwd=2)
plot_title <- paste(colnames(EuStockMarkets)[1], 
          'Q-Q Plot')
title(main=plot_title, line=-1)  # add title
shapiro.test(dax_rets)  # Shapiro-Wilk test



set.seed(1121)  # initialize the random number generator
par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
library(zoo)  # load package zoo
# create index of daily dates
date_index <- seq(from=as.Date("2014-07-14"), 
            by="day", length.out=1000)
# create zoo time series
zoo_series <- zoo(cumsum(rnorm(length(date_index))), 
            order.by=date_index)

class(zoo_series)  # class 'zoo'
tail(zoo_series, 4)  # get last few elements

# call plot.zoo
plot(zoo_series, xlab="", ylab="")
title(main="Random Prices", line=-1)  # add title



library(zoo)  # load package zoo
# create zoo time series
date_index <- Sys.Date() + 0:3
zoo_series <- zoo(rnorm(length(date_index)), 
         order.by=date_index)
zoo_series
index(zoo_series)  # extract time index
coredata(zoo_series)  # extract coredata
zoo_series[start(zoo_series)]  # first element
zoo_series[end(zoo_series)]  # last element
coredata(zoo_series) <- rep(1, 4)  # replace coredata
cumsum(zoo_series)  # cumulative sum
cummax(cumsum(zoo_series))
cummin(cumsum(zoo_series))



library(zoo)  # load package zoo
coredata(zoo_series) <- 1:4  # replace coredata
zoo_series
diff(zoo_series)  # diff with one day lag
lag(zoo_series, 2)  # two day lag



set.seed(1121)  # initialize the random number generator
par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
library(zoo)  # load package zoo
# create daily date series of class 'Date'
date_index1 <- seq(Sys.Date(), by="days", 
             length.out=365)
# create zoo time series
zoo_series1 <- zoo(rnorm(length(date_index1)), 
           order.by=date_index1)
# create another zoo time series
date_index2 <- seq(Sys.Date()+350, by="days", 
             length.out=365)
zoo_series2 <- zoo(rnorm(length(date_index2)), 
           order.by=date_index2)
# rbind the two time series - ts1 supersedes ts2
zoo_series3 <- rbind(zoo_series1,
           zoo_series2[index(zoo_series2) > end(zoo_series1)])
plot(cumsum(zoo_series3), xlab="", ylab="")
# add vertical lines at stitch point
abline(v=end(zoo_series1), col="blue", lty="dashed")
abline(v=start(zoo_series2), col="red", lty="dashed")
title(main="Random Prices", line=-1)  # add title



# create daily date series of class 'Date'
date_index1 <- Sys.Date() + -3:1
# create zoo time series
zoo_series1 <- zoo(rnorm(length(date_index1)), 
         order.by=date_index1)
# create another zoo time series
date_index2 <- Sys.Date() + -1:3
zoo_series2 <- zoo(rnorm(length(date_index2)), 
         order.by=date_index2)
merge(zoo_series1, zoo_series2)  # union of dates
# intersection of dates
merge(zoo_series1, zoo_series2, all=FALSE)



library(zoo)  # load package zoo
# create zoo time series
zoo_series <- zoo(rnorm(4), 
            order.by=(Sys.Date() + 0:3))
# add NA
zoo_series[3] <- NA
zoo_series

na.locf(zoo_series)  # replace NA's using locf

na.omit(zoo_series)  # remove NA's using omit



set.seed(1121)  # for reproducibility
par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
library(zoo)  # load package zoo
# create zoo time series
date_index <- Sys.Date() + 0:365
zoo_series <- zoo(rnorm(length(date_index)), order.by=date_index)
# create monthly dates
dates_agg <- as.Date(as.yearmon(index(zoo_series)))
# perform monthly 'mean' aggregation
zoo_agg <- aggregate(zoo_series, by=dates_agg, 
               FUN=mean)
# merge with original zoo - union of dates
zoo_agg <- merge(zoo_series, zoo_agg)
# replace NA's using locf
zoo_agg <- na.locf(zoo_agg)
# extract aggregated zoo
zoo_agg <- zoo_agg[index(zoo_series), 2]
# plot original and aggregated zoo
plot(cumsum(zoo_series), xlab="", ylab="")
lines(cumsum(zoo_agg), lwd=2, col="red")
# add legend
legend("topright", inset=0.05, cex=0.8, title="Aggregated Prices", 
 leg=c("orig prices", "agg prices"), lwd=2, bg="white", 
 col=c("black", "red"))



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
# perform monthly 'mean' aggregation
zoo_agg <- aggregate(zoo_series, by=dates_agg, 
               FUN=mean)
# merge with original zoo - union of dates
zoo_agg <- merge(zoo_series, zoo_agg)
# replace NA's using linear interpolation
zoo_agg <- na.approx(zoo_agg)
# extract interpolated zoo
zoo_agg <- zoo_agg[index(zoo_series), 2]
# plot original and interpolated zoo
plot(cumsum(zoo_series), xlab="", ylab="")
lines(cumsum(zoo_agg), lwd=2, col="red")
# add legend
legend("topright", inset=0.05, cex=0.8, title="Interpolated Prices", 
 leg=c("orig prices", "interpol prices"), lwd=2, bg="white", 
 col=c("black", "red"))



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
# perform monthly 'mean' aggregation
zoo_mean <- rollapply(zoo_series, width=11, FUN=mean)
# merge with original zoo - union of dates
zoo_mean <- merge(zoo_series, zoo_mean)
# replace NA's using na.locf
zoo_mean <- na.locf(zoo_mean, fromLast=TRUE)
# extract mean zoo
zoo_mean <- zoo_mean[index(zoo_series), 2]
# plot original and interpolated zoo
plot(cumsum(zoo_series), xlab="", ylab="")
lines(cumsum(zoo_mean), lwd=2, col="red")
# add legend
legend("topright", inset=0.05, cex=0.8, title="Mean Prices", 
 leg=c("orig prices", "mean prices"), lwd=2, bg="white", 
 col=c("black", "red"))



library(lubridate)  # load lubridate
library(zoo)  # load package zoo
# methods(as.zoo)  # many methods of coercing into zoo
class(EuStockMarkets)  # multiple ts object
# convert mts object into zoo
zoo_series <- as.zoo(EuStockMarkets)
class(index(zoo_series))  # index is numeric
head(zoo_series, 3)
# approximately convert index into class 'Dates'
index(zoo_series) <- as.Date(365*(index(zoo_series)-1970))
head(zoo_series, 3)
# convert index into class 'Dates'
zoo_series <- as.zoo(EuStockMarkets)
index(zoo_series) <- date_decimal(index(zoo_series))
head(zoo_series, 3)



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
library(tseries)  # load package tseries
zoo_msft <- suppressWarnings(  # load MSFT data
  get.hist.quote(instrument="MSFT", 
           start=Sys.Date()-365, 
           end=Sys.Date(), 
           origin="1970-01-01")
)  # end suppressWarnings
class(zoo_msft)
dim(zoo_msft)
tail(zoo_msft, 4)

sharpe(zoo_msft[, "Close"], r=0.01)  # calculate Sharpe ratio

plot(zoo_msft[, "Close"], xlab="", ylab="")
title(main="MSFT Close Prices", line=-1)  # add title



par(mar=c(7, 2, 1, 2), mgp=c(2, 1, 0), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
library(tseries)  # load package tseries
zoo_eurusd <- suppressWarnings(  # load EUR/USD data
  get.hist.quote(
    instrument="EUR/USD", provider="oanda",
    start=Sys.Date()-365, 
    end=Sys.Date(), 
    origin="1970-01-01")
)  # end suppressWarnings
# bind and scrub data
zoo_msfteur <- merge(zoo_eurusd, 
               zoo_msft[, "Close"])
colnames(zoo_msfteur) <- c("EURUSD", "MSFT")
zoo_msfteur <- 
  zoo_msfteur[complete.cases(zoo_msfteur),]
### plot with two "y" axes
par(las=1)  # set text printing to "horizontal"
# plot first ts
plot(zoo_msfteur[, 1], xlab=NA, ylab=NA)
# set range of "y" coordinates for second axis
par(usr=c(par("usr")[1:2], range(zoo_msfteur[,2])))
lines(zoo_msfteur[, 2], col="red")  # second plot
axis(side=4, col="red")  # second "y" axis on right
# print axis labels
mtext(colnames(zoo_msfteur)[1], side=2, padj=-6, line=-4)
mtext(colnames(zoo_msfteur)[2], col="red", side=4, padj=-2, line=-3)
title(main="EUR and MSFT")  # add title
# add legend without box
legend("bottomright", legend=colnames(zoo_msfteur), bg="white", 
 lty=c(1, 1), lwd=c(2, 2), col=c("black", "red"), bty="n")


##########

# slightly different method using par(new=TRUE)
# par(las=1)  # set text printing to "horizontal"
# plot(zoo_msfteur[, 1], xlab=NA, ylab=NA)
# par(new=TRUE)  # allow new plot on same chart
# plot(zoo_msfteur[, 2], xlab=NA, ylab=NA, yaxt="n", col="red")
# axis(side=4, col="red")  # second "y" axis on right
# mtext(colnames(zoo_msfteur)[1], side=2, padj=-6, line=-4)
# mtext(colnames(zoo_msfteur)[2], col="red", side=4, padj=-2, line=-3)
# title(main="EUR and MSFT", line=-1)  # add title
# legend("bottomright", legend=colnames(zoo_msfteur), 
#        lty=c(1, 1), lwd=c(2, 2), col=c("black", "red"), bty="n")

##########

# "x" axis with monthly ticks - doesn't work
# plot first ts wthout "x" axis
# plot(zoo_msfteur[, 1], xaxt="n", xlab=NA, ylab=NA)
# # add "x" axis with monthly ticks
# month.ticks <- unique(as.yearmon(index(zoo_eurusd)))
# axis(side=1, at=month.ticks, labels=format(month.ticks, "%b-%y"), tcl=-0.7)




ts_msft <- as.ts(zoo_msft)
class(ts_msft)
# rename colnames
colnames(ts_msft) <- paste0("MSFT.", colnames(ts_msft))
tail(ts_msft, 4)

library(timeSeries)
tser_msft <- as.timeSeries(zoo_msft)
class(ts_msft)
tail(tser_msft, 4)



par(mar=c(5,0,1,2), oma=c(1,2,1,0), mgp=c(2,1,0), cex.lab=0.8, cex.axis=1.0, cex.main=0.8, cex.sub=0.5)
library(zoo)  # load package zoo
# autocorrelation from "stats"
acf(coredata(dax_rets), lag=10, main="")
title(main="acf of DAX returns", line=-1)



library(zoo)  # load package zoo
dax_acf <- acf(coredata(dax_rets), plot=FALSE)
summary(dax_acf)  # get the structure of the "acf" object
# print(dax_acf)  # print acf data
dim(dax_acf$acf)
dim(dax_acf$lag)
head(dax_acf$acf)



acf_plus <- function (ts_data, plot=TRUE, 
                xlab="Lag", ylab="", 
                main="", ...) {
  acf_data <- acf(x=ts_data, plot=FALSE, ...)
# remove first element of acf data
  acf_data$acf <-  array(data=acf_data$acf[-1], 
    dim=c((dim(acf_data$acf)[1]-1), 1, 1))
  acf_data$lag <-  array(data=acf_data$lag[-1], 
    dim=c((dim(acf_data$lag)[1]-1), 1, 1))
  if(plot) {
    ci <- qnorm((1+0.95)/2)*sqrt(1/length(ts_data))
    ylim <- c(min(-ci, range(acf_data$acf[-1, , 1])),
        max(ci, range(acf_data$acf[-1, , 1])))
    plot(acf_data, xlab=xlab, ylab=ylab, 
   ylim=ylim, main=main, ci=0)
    abline(h=c(-ci, ci), col="blue", lty=2)
  }
  invisible(acf_data)  # return invisibly
}  # end acf_plus



par(mar=c(5,0,1,2), oma=c(1,2,1,0), mgp=c(2,1,0), cex.lab=0.8, cex.axis=1.0, cex.main=0.8, cex.sub=0.5)
library(zoo)  # load package zoo
# improved autocorrelation function
acf_plus(coredata(dax_rets), lag=10, main="")
title(main="acf of DAX returns", line=-1)



library(Ecdat)  # load Ecdat
colnames(Macrodat)  # United States Macroeconomic Time Series
macro_zoo <- as.zoo(  # coerce to "zoo"
    Macrodat[, c("lhur", "fygm3")])
colnames(macro_zoo) <- c("unemprate", "3mTbill")
# ggplot2 in multiple panes
autoplot(  # generic ggplot2 for "zoo"
  object=macro_zoo, main="US Macro",
  facets=Series ~ .) + # end autoplot
  xlab("") + 
theme(  # modify plot theme
  legend.position=c(0.1, 0.5),
  plot.title=element_text(vjust=-2.0),
  plot.margin=unit(c(-0.5, 0.0, -0.5, 0.0), "cm"),
  plot.background=element_blank(),
  axis.text.y=element_blank()
)  # end theme



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2,1))  # set plot panels
macro_diff <- na.omit(diff(macro_zoo))

acf_plus(coredata(macro_diff[, "unemprate"]), 
   lag=10)
title(main="quarterly unemployment rate", 
line=-1)

acf_plus(coredata(macro_diff[, "3mTbill"]), 
   lag=10)
title(main="3 month T-bill EOQ", line=-1)



# Ljung-Box test for DAX data
# 'lag' is the number of autocorrelation coefficients
Box.test(dax_rets, lag=10, type="Ljung")

# changes in 3 month T-bill rate are autocorrelated
Box.test(macro_diff[, "3mTbill"], 
   lag=10, type="Ljung")

# changes in unemployment rate are autocorrelated
Box.test(macro_diff[, "unemprate"], 
   lag=10, type="Ljung")



library(zoo)  # load zoo
library(ggplot2)  # load ggplot2
library(gridExtra)  # load gridExtra
# extract DAX time series
dax_ts <- EuStockMarkets[, 1]
# filter past values only (sides=1)
dax_filt <- filter(dax_ts, 
             filter=rep(1/5,5), sides=1)
# coerce to zoo and merge the time series
dax_filt <- merge(as.zoo(dax_ts), 
            as.zoo(dax_filt))
colnames(dax_filt) <- c("DAX", "DAX filtered")
dax_data <- window(dax_filt, 
             start=1997, end=1998)
autoplot(  # plot ggplot2
    dax_data, main="Filtered DAX", 
    facets=NULL) +  # end autoplot
xlab("") + ylab("") +
theme(  # modify plot theme
    legend.position=c(0.1, 0.5), 
    plot.title=element_text(vjust=-2.0), 
    plot.margin=unit(c(-0.5, 0.0, -0.5, 0.0), "cm"), 
    plot.background=element_blank(),
    axis.text.y=element_blank()
    )  # end theme
# end ggplot2



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
dax_rets <- na.omit(diff(log(dax_filt)))
par(mfrow=c(2,1))  # set plot panels

acf_plus(coredata(dax_rets[, 1]), lag=10, 
   xlab="")
title(main="DAX", line=-1)

acf_plus(coredata(dax_rets[, 2]), lag=10, 
   xlab="")
title(main="DAX filtered", line=-1)



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2,1))  # set plot panels
# autocorrelation from "stats"
acf_plus(dax_rets[, 2], lag=10, xlab=NA, ylab=NA)
title(main="DAX filtered autocorrelations", line=-1)
# partial autocorrelation
pacf(dax_rets[, 2], lag=10, xlab=NA, ylab=NA)
title(main="DAX filtered partial autocorrelations", 
      line=-1)



# ARIMA processes
library(ggplot2)  # load ggplot2
library(gridExtra)  # load gridExtra
daily_index <- Sys.Date() + 0:364  # one year daily series
ar_zoo <- zoo(  # AR time series of returns
  x=arima.sim(n=365, model=list(ar=0.2)),
  order.by=daily_index)  # ar_zoo
ar_zoo <- cbind(ar_zoo, cumsum(ar_zoo))
colnames(ar_zoo) <- c("AR returns", "AR prices")
# plot AR returns
autoplot(object=ar_zoo, 
 facets="Series ~ .", 
 main="Autoregressive process (phi=0.2)") + 
  facet_grid("Series ~ .", scales="free_y") +
  xlab("") + ylab("") + 
theme(
  legend.position=c(0.1, 0.5), 
#  plot.title=element_text(vjust=-1.0), 
  plot.background=element_blank(),
  axis.text.y=element_blank())



ar_coeff <- c(0.01, 0.4, 0.8)  # AR coefficients
ar_zoo <- sapply(  # create three AR time series
  ar_coeff, function(phi)
    arima.sim(n=365, model=list(ar=phi)))
ar_zoo <- zoo(x=ar_zoo, order.by=daily_index)
ar_zoo <- cumsum(ar_zoo)  # returns to prices
colnames(ar_zoo) <- paste("autocorr", ar_coeff)
autoplot(ar_zoo, main="AR prices", 
   facets=Series ~ .) + 
    facet_grid(Series ~ ., scales="free_y") +
xlab("") + 
theme(
  legend.position=c(0.1, 0.5), 
  plot.title=element_text(vjust=-2.0), 
  plot.margin=unit(c(-0.5, 0.0, -0.5, 0.0), "cm"), 
  plot.background=element_blank(),
  axis.text.y=element_blank())



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2,1))  # set plot panels
# ACF of AR(1) process
acf_plus(na.omit(diff(ar_zoo[, 2])), lag=10, 
 xlab="", ylab="", main="ACF of AR(1) process")

# PACF of AR(1) process
pacf(na.omit(diff(ar_zoo[, 2])), lag=10,
     xlab="", ylab="", main="PACF of AR(1) process")



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2,1))  # set plot panels
ar3_zoo <- zoo(  # AR(3) time series of returns
  x=arima.sim(n=365, 
    model=list(ar=c(0.1, 0.5, 0.1))),
  order.by=daily_index)  # ar_zoo
# ACF of AR(3) process
acf_plus(ar3_zoo, lag=10, 
 xlab="", ylab="", main="ACF of AR(3) process")

# PACF of AR(3) process
pacf(ar3_zoo, lag=10,
     xlab="", ylab="", main="PACF of AR(3) process")



ar3_zoo <- arima.sim(n=1000, 
      model=list(ar=c(0.1, 0.3, 0.1)))
arima(ar3_zoo, order = c(5,0,0))  # fit AR(5) model
library(forecast)  # load forecast
auto.arima(ar3_zoo)  # fit ARIMA model



# formula of linear model with zero intercept
lin_formula <- z ~ x + y - 1
lin_formula

# collapsing a character vector into a text string
paste0("x", 1:5)
paste(paste0("x", 1:5), collapse="+")

# creating formula from text string
lin_formula <- as.formula(  # coerce text strings to formula
        paste("y ~ ", 
          paste(paste0("x", 1:5), collapse="+")
          )  # end paste
      )  # end as.formula
class(lin_formula)
lin_formula
# modify the formula using "update"
update(lin_formula, log(.) ~ . + beta)



set.seed(1121)  # initialize random number generator
indep_var <- 0.1*1:30  # independent (explanatory) variable
# dependent (response) variable equals linear form plus noise
depend_var <- 3 + 2*indep_var + rnorm(30)
# specify regression formula
reg_formula <- depend_var ~ indep_var
reg_model <- lm(reg_formula)  # perform regression
class(reg_model)  # regressions have class lm
attributes(reg_model)
eval(reg_model$call$formula)  # the regression formula
reg_model$coefficients  # the regression formula coefficients
coef(reg_model)



par(oma=c(1, 2, 1, 0), mgp=c(2, 1, 0), mar=c(5, 1, 1, 1), cex.lab=0.8, cex.axis=1.0, cex.main=0.8, cex.sub=0.5)
plot(reg_formula)  # plot scatterplot using formula
title(main="Simple Regression", line=-1)
# add regression line
abline(reg_model, lwd=2, col="red")
# plot fitted (predicted) response values
points(x=indep_var, y=reg_model$fitted.values, 
       pch=16, col="blue")



reg_model_sum <- summary(reg_model)  # copy regression summary
reg_model_sum  # print the summary to console
attributes(reg_model_sum)$names  # get summary elements



reg_model_sum$coefficients
reg_model_sum$r.squared
reg_model_sum$adj.r.squared
reg_model_sum$fstatistic
anova(reg_model)



set.seed(1121)  # initialize random number generator
# small coefficient between response and explanatory variables
depend_var <- 3 + 0.2*indep_var + rnorm(30)
reg_model <- lm(reg_formula)  # perform regression
# the estimate of the coefficient is not statistically significant
summary(reg_model)



# set plot paramaters - margins and font scale
par(oma=c(1, 0, 1, 0), mgp=c(2, 1, 0), mar=c(2, 1, 2, 1), cex.lab=0.8, cex.axis=1.0, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2, 2))  # plot 2x2 panels
plot(reg_model)  # plot diagnostic scatterplots
plot(reg_model, which=2)  # plot just Q-Q



depend_var <- 3 + 2*indep_var + rnorm(30)
reg_formula <- depend_var ~ indep_var
reg_model <- lm(reg_formula)  # perform regression
library(lmtest)  # load lmtest

# perform Durbin-Watson test
dwtest(reg_model)



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2,1))  # set plot panels
library(lmtest)  # load lmtest
design_matrix <- data.frame(  # design matrix
  indep_var=1:30, omit_var=sin(0.2*1:30))
# response depends on both explanatory variables
depend_var <- with(design_matrix, 
  0.2*indep_var + omit_var + 0.2*rnorm(30))
# mis-specified regression only one explanatory
reg_model <- lm(depend_var ~ indep_var, 
        data=design_matrix)
reg_model_sum <- summary(reg_model)
reg_model_sum$coefficients
reg_model_sum$r.squared
# Durbin-Watson test shows residuals are autocorrelated
dwtest(reg_model)$p.value
plot(reg_formula, data=design_matrix)
abline(reg_model, lwd=2, col="red")
title(main="OVB Regression", line=-1)
plot(reg_model, which=2, ask=FALSE)  # plot just Q-Q



par(oma=c(15, 1, 1, 1), mgp=c(0, 0.5, 0), mar=c(1, 1, 1, 1), cex.lab=0.8, cex.axis=0.8, cex.main=0.8, cex.sub=0.5)
par(mfrow=c(2,1))  # set plot panels
set.seed(1121)
library(lmtest)
# spurious regression in unit root time series
indep_var <- cumsum(rnorm(100))  # unit root time series
depend_var <- cumsum(rnorm(100))
reg_formula <- depend_var ~ indep_var
reg_model <- lm(reg_formula)  # perform regression
# summary indicates statistically significant regression
reg_model_sum <- summary(reg_model)
reg_model_sum$coefficients
reg_model_sum$r.squared
# Durbin-Watson test shows residuals are autocorrelated
dw_test <- dwtest(reg_model)
c(dw_test$statistic[[1]], dw_test$p.value)
plot(reg_formula, xlab="", ylab="")  # plot scatterplot using formula
title(main="Spurious Regression", line=-1)
# add regression line
abline(reg_model, lwd=2, col="red")
plot(reg_model, which=2, ask=FALSE)  # plot just Q-Q



indep_var <- 0.1*1:30  # explanatory variable
depend_var <- 3 + 2*indep_var + rnorm(30)
reg_formula <- depend_var ~ indep_var
reg_model <- lm(reg_formula)  # perform regression
new_data <- data.frame(indep_var=0.1*31:40)
predict_lm <- predict(object=reg_model, 
              newdata=new_data, level=0.95, 
              interval="confidence")
predict_lm <- as.data.frame(predict_lm)
head(predict_lm, 2)
plot(reg_formula, xlim=c(1.0, 4.0), 
     ylim=range(depend_var, predict_lm),
     main="Regression predictions")
abline(reg_model, col="red")
with(predict_lm, {
  points(x=new_data$indep_var, y=fit, pch=16, col="blue")
  lines(x=new_data$indep_var, y=lwr, lwd=2, col="red")
  lines(x=new_data$indep_var, y=upr, lwd=2, col="red")
})  # end with

