% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_tree.R
\name{plot_tree}
\alias{plot_tree}
\title{Plot tree structure}
\usage{
plot_tree(gbm, tree_no, plot_path = NULL)
}
\arguments{
\item{gbm}{\code{gbm.object} to predict with.}

\item{tree_no}{specific tree to plot from the model.}

\item{plot_path}{single row \code{data.frame} to predict and the 
decompose into feature contributions. Default value \code{NULL} means not
terminal node path will be displayed.}
}
\value{
function does not return anything but plots tree structure.
}
\description{
Plot structure for given tree in gbm, with the option to display the path
to a terminal node for 1 row of data.
}
\examples{
N <- 1000
X1 <- runif(N)
X2 <- 2*runif(N)
X3 <- ordered(sample(letters[1:4],N,replace=TRUE),levels=letters[4:1])
X4 <- factor(sample(letters[1:6],N,replace=TRUE))
X5 <- factor(sample(letters[1:3],N,replace=TRUE))
X6 <- 3*runif(N) 
mu <- c(-1,0,1,2)[as.numeric(X3)]

SNR <- 10 # signal-to-noise ratio
Y <- X1**1.5 + 2 * (X2**.5) + mu
sigma <- sqrt(var(Y)/SNR)
Y <- Y + rnorm(N,0,sigma)

# introduce some missing values
X1[sample(1:N,size=500)] <- NA
X4[sample(1:N,size=300)] <- NA

data <- data.frame(Y=Y,X1=X1,X2=X2,X3=X3,X4=X4,X5=X5,X6=X6)

# fit initial model
gbm1 <- gbm(Y~X1+X2+X3+X4+X5+X6,        
           data=data,                  
           var.monotone=c(0,0,0,0,0,0),
           distribution="gaussian",   
           n.trees=1000,     
           shrinkage=0.05,  
           interaction.depth=3,
           bag.fraction = 0.5,
           train.fraction = 0.5)

plot_tree(gbm1, 1, data[1, ])

}
