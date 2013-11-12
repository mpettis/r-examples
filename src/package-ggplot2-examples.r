########################################################################
## ggplot2.
## Will sometimes require support packages for some of the options.
## Most nicely run in RStudio.
##
## More references:
##      http://www.cookbook-r.com/Graphs/
########################################################################

library(ggplot2)
    ## scales needed for special 'label' parameter values inside 'scale_x_*' and 'scale_y_*'
    ## functions.  Things like the 'label=comma' parameter value and
    ## 'labels=date_format' parameter value.
library(scales)



    ## Make up a dataset to work with
dat01 <- expand.grid(Date=seq(as.Date("2008-01-01"), as.Date("2008-12-31"), by="1 week"),
            Var1=LETTERS[1:5],
            Var2=letters[22:26],
            VarInt=1:5,
            stringsAsFactors=FALSE,
            KEEP.OUT.ATTRS=FALSE)
dat01$Value <- runif(nrow(dat01)) * 10000
dat01$ValueInt <- sample(1:20, nrow(dat01), replace=TRUE)
str(dat01)
head(dat01)



########################################################################
## Stuff with geom_line that has Dates in x-axis
########################################################################

    ##
    ## Single-line timeseries
    ##
tmp <- aggregate(Value ~ Date, data=dat01, sum)
head(tmp)
p <- ggplot(tmp, aes(Date, Value)) +
            ## does line plot
        geom_line() +
            ## theme helps with layout.
        theme(
                ## puts x-axis labels so they read vertically, not horizontally.
            axis.text.x = element_text(angle = 90, hjust = 1),
                ## ensure y-axis labels read horizontally.
            strip.text.y = element_text(angle = 0)) +
            ## label x axis
        xlab("Date Axis") +
            ## fine-tune the dates here.  Make sure the major ticks are every 3 months,
            ## and ensure the format of the date stamp is %Y-%m-%d.  requires 'library(scales)'.
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
            ## Format y-axis labels to have commas.  requires 'library(scales)'
        scale_y_continuous(labels=comma) +
            ## Top title of overall chart.
        ggtitle("Example: Single-line timeseries")
print(p)





    ##
    ## Grouped timeseries
    ## Gropued by Var1.  Each line is a timeseries for each different value of Var1.
    ##
tmp <- aggregate(Value ~ Date + Var1, data=dat01, sum)
head(tmp)
    ## Need to use the 'group' and 'color' to make this happen.  'group' ensures that each value
    ## of Var1 gets its own line, and 'color' makes sure that each line gets its own color.
p <- ggplot(tmp, aes(Date, Value, group=Var1, color=Var1)) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        ggtitle("Example: Grouped timeseries")
print(p)





    ##
    ## Faceted timeseries (Horizontal stack)
    ## Faceted by Var1.  Each facet(graph) is a timeseries for each different value of Var1.
    ##
tmp <- aggregate(Value ~ Date + Var1, data=dat01, sum)
head(tmp)
    ## Need to use the 'group' and 'color' to make this happen.  'group' ensures that each value
    ## of Var1 gets its own line, and 'color' makes sure that each line gets its own color.
p <- ggplot(tmp, aes(Date, Value)) +
            ## In formula, variable to left of ~ is the variable of the rows
        facet_grid( Var1 ~ .) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        ggtitle("Example: Faceted timeseries (Horizontal stack)")
print(p)





    ##
    ## Faceted timeseries (Vertical stack)
    ## Faceted by Var1.  Each facet(graph) is a timeseries for each different value of Var1.
    ##
tmp <- aggregate(Value ~ Date + Var1, data=dat01, sum)
head(tmp)
p <- ggplot(tmp, aes(Date, Value)) +
            ## In formula, variable to right of ~ is the variable of the cols
        facet_grid( . ~ Var1 ) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        ggtitle("Example: Faceted timeseries (Vertical stack)")
print(p)





    ##
    ## Grouped and faceted timeseries
    ## Faceted by Var1, grouped by Var2.
    ## Each line is a timeseries for each different value of Var2, each horizontal strip
    ## is a different value of Var1.
    ##
tmp <- aggregate(Value ~ Date + Var1 + Var2, data=dat01, sum)
head(tmp)
p <- ggplot(tmp, aes(Date, Value, group=Var2, color=Var2)) +
        facet_grid( Var1 ~ .) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        ggtitle("Example: Grouped and faceted timeseries")
print(p)





    ##
    ## Grouped timeseries, numeric group variable.
    ## Gropued by VarInt.  Note that even though VarInt are integers, it assumes VarInt is a
    ## continuous value, and gives you a color gradient for the line colors, rather than
    ## just distinct colors for the integers.  This may or may not be what you want.
    ##
tmp <- aggregate(Value ~ Date + VarInt, data=dat01, sum)
head(tmp)
p <- ggplot(tmp, aes(Date, Value, group=VarInt, color=VarInt)) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        ggtitle("Example: Grouped timeseries, numeric group variable.")
print(p)

    ## If you want these integers treated like categorical variable values, rather then possible
    ## continuous variables, you must make VarInt into a factor in the 'color' aesthetic.
    ## You can do this inline, as shown here, or you can make a new variable (or transform
    ## this one) into a factor of these values.  I show the shortcut here.
p <- ggplot(tmp, aes(Date, Value, group=VarInt, color=as.factor(VarInt))) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        ggtitle("Example: Grouped timeseries, numeric group variable, color is factor.")
print(p)

    ## Here, you can use 'scale_colour_discrete' to title the legend.  If color is not made into
    ## a factor here, you must use 'scale_colour_gradient' to set the legend title.
p <- ggplot(tmp, aes(Date, Value, group=VarInt, color=as.factor(VarInt))) +
        geom_line() +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            strip.text.y = element_text(angle = 0)) +
        xlab("Date Axis") +
        scale_x_date(breaks=seq(min(dat01$Date), max(dat01$Date), by="3 month"), labels = date_format("%Y-%m")) +
        ylab("Value Axis") +
        scale_y_continuous(labels=comma) +
        scale_colour_discrete(name ="New Legend Title") +
        ggtitle("Example: Grouped timeseries, numeric group variable, color is factor, set legend title.")
print(p)





########################################################################
## Histograms
########################################################################

    ##
    ## Bare histogram
    ## Kinda ugly, bars aren't nicely spaced.
    ##
p <- ggplot(dat01, aes(ValueInt)) +
        geom_histogram() +
        ggtitle("Example: Bare histogram")
print(p)

    ## Space the bars by declaring that ValueInt is discrete
p <- ggplot(dat01, aes(ValueInt)) +
        geom_histogram() +
            ## Declare ValueInt to be discrete.
        scale_x_discrete() +
        ggtitle("Example: Bare histogram, discrete bins.")
print(p)


    ##
    ## Weighted histogram
    ## Histogram of Value, but weighted by ValueInt.
    ## You'll get a warning saying binwidth = range/30.  You can fiddle with binwidth
    ## if you want to to get more/fewer bins, things in the bins, binwidth, etc.
    ##
p <- ggplot(dat01, aes(Value)) +
        geom_histogram(aes(weight=ValueInt)) +
        ggtitle("Example: Weighted histogram")
print(p)


