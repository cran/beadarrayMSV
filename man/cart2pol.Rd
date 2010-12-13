\name{cart2pol}
\Rdversion{1.1}
\alias{cart2pol}
\title{
  Transformation from Cartesian to polar coordinates
}
\description{
  Cartesian coordiantes are transformed to polar coordinates using a
  specified distance measure
}
\usage{
cart2pol(x, y, dist = "euclidean", pNorm = NULL)
}
\arguments{
  \item{x}{
    Cartesian abscissa value
  }
  \item{y}{
    Cartesian ordinate value
  }
  \item{dist}{
    One of \dQuote{manhattan}, \dQuote{euclidean} (default), or
    \dQuote{minkowski}, defining which distance measure to use
  }
  \item{pNorm}{
    The exponent \dQuote{p} in the p-norm (Minkowski) distance
  }
}
\details{
  The Manhattan distance is the special case of the Minkowski distance of
  norm 1, the Euclidean distance equals the Minkowski distance of norm
  2. The unit circle of the Minkowski distance changes from a diamond
  shape (1-norm), through an Euclidean circle (2-norm),
  to a square (infinity-norm) as \code{pNorm} increases from 1 to
  infinity. Any norm between 2 and infinity results in a unit circle
  resembling a square with more or less rounded corners.

  For non-transformed signal, the 1-norm is the most accurate
  representation, however a higher norm is called for after root- or
  log-transformations.
}
\value{
  A list holding the polar coordinates
  \item{r }{Signal intensity}
  \item{th }{Polar angle}
}
\author{
  Lars Gidskehaug
}
\seealso{
  \code{\link{preprocessBeadSet}}, \code{\link{setNormOptions}}
}
\examples{
## Points defining a 4-norm unit-circle in the first quadrant
x <- seq(0,1,.01)^(1/4)
y <- (1-x^4)^(1/4)

## Polar coordinates using different distance-measures
eucl <- cart2pol(x,y)
mink <- cart2pol(x,y,'minkowski',4)

\dontrun{
## Plot in cartesian coordinates
dev.new()
plot(x,y,type='b',main='4-norm unit circle')

## Plot polar coordinates on cartesian axes
dev.new()
plot(eucl$th,eucl$r,type='b',col='red',xlab='theta',ylab='r')
points(mink$th,mink$r,type='b',col='blue')
title(main='Euclidean (red) and 4-norm (blue) distance')}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
