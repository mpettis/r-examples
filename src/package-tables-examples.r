## See: http://cran.r-project.org/web/packages/tables/vignettes/tables.pdf

################################################################################
## Setup
################################################################################

library(tables)

    ## typical made-up data
ex_rows <- 22
dat_ex <- data.frame(
            x=sample(LETTERS[1:5], ex_rows, replace=TRUE),
            y=sample(letters[11:15], ex_rows, replace=TRUE),
            z=sample(letters[1:5], ex_rows, replace=TRUE),
            n=sample(1:10, ex_rows, replace=TRUE)
            )

str(esoph)

    ## From the Vignette
set.seed(100)
X <- rnorm(10)
A <- sample(letters[1:2], 10, rep=TRUE)
F <- factor(A)

################################################################################
## Examples
## esoph has ordered factors, dat_ex does not have factors  
################################################################################

    ## Build up some simple ones
tabular(agegp ~ ncontrols*sum, data=esoph)
tabular(x ~ n*sum, data=dat_ex)

dtabular(agegp*alcgp ~ ncontrols*sum, data=esoph)
tabular(x*y ~ n*sum, data=dat_ex)


################################################################################
## Vignette examples
################################################################################
tabular(F + 1 ~ 1)

tabular( X*F*(mean + sd) ~ 1 )
tabular( F*X*(mean + sd) ~ 1 )

tabular( X*F ~ mean + sd )

tabular( X*(Newname=F) ~ mean + sd )

tabular( (F+1) ~ (n=1) + X*(mean + sd) )

tabular( (i = factor(seq_along(X))) ~ Heading()*identity*(X + A + (F = as.character(F))))
tabular( (i = factor(seq_along(X))) ~ identity*(X + A + (F = as.character(F))))
tabular( (i = factor(seq_along(X))) ~ (X + A + (F = as.character(F))))
tabular( (i = factor(seq_along(X))) ~ identity*(X + A))
tabular( (i = factor(seq_along(X))) ~ Heading()*identity*(X + A))

tabular( (X > 0) + (X < 0) + 1 ~ ((n = 1) + X*(mean + sd)))

tabular( I(X > 0) + I(X < 0) ~ ((n=1) + mean + sd))

tabular( (F+1) ~ (n=1) + Format(digits=2)*X*(mean + sd))

tabular( Justify(r)*(F+1) ~ Justify(c)*(n=1) + Justify(c,r)*Format(digits=2)*X*(mean + sd) )

tabular( (Factor(gear, "Gears") + 1) * ((n=1) + Percent() + (RowPct=Percent("row")) + (ColPct=Percent("col")))
         ~ (Factor(carb, "Carburetors") + 1)*Format(digits=1), data=mtcars )

tabular( Species ~ Heading()*mean*All(iris), data=iris)
