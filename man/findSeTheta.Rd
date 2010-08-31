\name{findSeTheta}
\Rdversion{1.1}
\alias{findSeTheta}
\title{
  Scale pooled standard errors after polar transformation
}
\description{
  After polar transformation of Cartesian intensity values, the
  estimated standard errors are no longer useful. This function
  normalizes the standard errors depending on the polar
  \dQuote{intensity} value
}
\usage{
findSeTheta(pooledSE.raw, R, dist = "manhattan", pNorm = NULL)
}
\arguments{
  \item{pooledSE.raw}{
    Matrix of pooled standard errors of the Cartesian intensities
    \dQuote{A} and \dQuote{B} (see \code{\link{createAlleleSet}})
  }
  \item{R}{
    Matrix of polar coordinates intensities
  }
  \item{dist}{
    Distance measure. See \code{\link{cart2pol}}
  }
  \item{pNorm}{
    Minkowski norm. See \code{\link{cart2pol}}
  }
}
\details{
  Usually called from within \code{\link{createAlleleSet}}. The standard
  errors of the Cartesian intensities \dQuote{A} and \dQuote{B} are not
  meaningful when the polar coordinates \dQuote{theta} and
  \dQuote{intensity} are plotted on Cartesian axes. In a plot of
  homoscedastic \dQuote{B} vs. \dQuote{A} (see
  \code{\link{transformChannels}}), the standard error of each bead-type
  is independent of the signal intensities. In a Cartesian plot of
  \dQuote{intensity} vs. \dQuote{theta}, however, bead-types with low
  intensity will have a large uncertainty, and the precision of the
  points will increase with increasing intensity. This is beacause the
  arc-length of the first quadrant semi-circle, which increases with the
  distance from origin, gets a constant value of unity as the polar
  coordinates are plotted on Cartesian axes. The pooled standard errors
  are therefore scaled with the intensity dependent arc-length of the
  semi-circle between 0 and 90 degrees.
  
  The arc-lengths by which the standard errors are scaled also depend on
  \code{dist} and \code{pNorm}. The circumference of a circle in
  Manhattan geometry, using a Euclidean metric, is
  \code{4*sqrt(2)*R}, and the circumference of a Euclidean circle is
  \code{2*pi*R}. It follows that the arc-lengths in the first quadrant
  only are \code{sqrt(2)*R} and \code{pi*R/2}, respectively. The more
  general arc-length of a Minkowski geometry circle is estimated by
  numerical integration along the the curve of the super-ellipse between
  0 to 90 degrees.
}
\value{
  Matrix of transformed standard errors
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
\author{
  Lars Gidskehaug
}
%\note{
%}
\seealso{
  \code{\link{cart2pol}}, \code{\link{createAlleleSet}}
}
\examples{
#A single standard error value for points of increasing intensity
R <- .1:10
pooledSE.raw <- 1
pooledSE.theta <- findSeTheta(pooledSE.raw=pooledSE.raw,R=R)
print(pooledSE.theta)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
