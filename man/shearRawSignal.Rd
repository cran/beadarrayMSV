\name{shearRawSignal}
\Rdversion{1.1}
\alias{shearRawSignal}
\alias{normalizeIllumina}
\title{
  Affine transformation of axes
}
\description{
  Mimicks the rotation and shearing of raw two-colour intensities
  performed in Illumina's GenomeStudio. To be performed before any other
  transformation or normalisation.
}
\usage{
shearRawSignal(BSData, plot = FALSE, newFigure = plot,
    normOpts = setNormOptions(), maxPlots = 72, ...)

normalizeIllumina(rawData, indTrain = rep(TRUE, length(rawData$x)),
    normOpts = setNormOptions(), plot = FALSE, xylim = NULL,
    verbose = FALSE)
}
\arguments{
  \item{BSData}{
    \code{"\linkS4class{BeadSetIllumina}"} object
  }
  \item{plot}{
    If \code{TRUE}, a scatter-plot including the estimated homozygote
    asymptotes is produced for each array in \code{BSData}
  }
  \item{newFigure}{
    Logical indicating whether or not to clear the current device before
    plotting. If \code{FALSE}, an error will be produced if more than
    one array is specified
  }
  \item{normOpts}{
    List with at least three elements: \dQuote{nBins}, \dQuote{minSize},
    and \dQuote{prob}. See
    \code{\link{setNormOptions}} 
  }
  \item{maxPlots}{
    Numeric indicating the maximum allowed number of arrays to
    plot. Exceeding this limit will produce an error
  }
  \item{\dots}{
    Additional input parameters to \code{normalizeIllumina}
  }
  \item{rawData}{
    List containing the numeric vectors \dQuote{x} and \dQuote{y} with
    red and green intensity data for a single array
  }
  \item{indTrain}{
    Logical index vector specifying which points to base the
    normalization upon. It may also be a list containing two logical
    index vectors \dQuote{10r} and \dQuote{20g}, containing indexes to
    all sub-bead pools with red and green Infinium I beads, respectively.
    In the latter case, the \dQuote{10r}-points are used to fit the
    \dQuote{AA} homozygote asymptote and the \dQuote{20g}-points are used
    to fit the \dQuote{BB} homozygote asymptote
  }
  \item{xylim}{
    If \code{plot}, these are the \code{c(xLow,xHigh,yLow,yHigh)}
    coordinates of the axes
  }
  \item{verbose}{
    If \code{TRUE}, the offset and slope of both asymptotes are printed
  }
}
\details{
\code{shearRawSignal} is usually used as a wrapper for
\code{normalizeIllumina}. Even more commonly,
\code{\link{preprocessBeadSet}} is used as a wrapper for both.

These functions perform an affine transformation which is similar to in
Illumina's software (Peiffer \emph{et al.}, 2006),
and it differs only in how the homozygote asymptotes are estimated. Both
axes are divided into a number of bins as specified by
\code{normOpts$nBins}. The points specified by
the quantile \code{normOpts$prob} in each bin exceeding
\code{normOpts$minSize} points are used for a least squares fit of
homozygote asymptotes. If \code{normOpts$shearInf1} is \code{TRUE}, only
Infinium I beads are used, and the quantiles are based on all points
in the bins. Otherwise, all points are used, however the quantile is
based on the \code{normOpts$minSize} smallest values only.

In the plot, the red and green lines give the estimated \dQuote{AA} and
\dQuote{BB} homozygote asymptotes, respectively. The blue dots are the
points upon which the rotation and shearing is based.
}
\value{
A \code{"\linkS4class{BeadSetIllumina}"} object from
\code{shearRawSignal}, or a list containing normalized signal from
\code{normalizeIllumina}. The normalized red and green signal is
transformed such that the \dQuote{AA} and \dQuote{BB} homozygotes
asymptotes are perpendicular to each other
}
\references{
  D. A. Peiffer \emph{et al.} (2006) High-resolution genomic profiling of
  chromosomal aberrations using Infinium whole-genome genotyping,
  \emph{Genome Res.} \bold{16}:1136-1148
}
\author{
  Lars Gidskehaug
}
\seealso{
\code{\link{preprocessBeadSet}}, \code{\link{setNormOptions}} 
}
\examples{
#Make artificial, heteroscedastic data
x1 <- 5 + exp(rnorm(1000))*100
y1 <- 100 + x1*.1 + x1*rnorm(1000,sd=.1)*.2
y2 <- 100 + exp(rnorm(1000))*70
x2 <- (y2-5)/10 + (y2-100)*rnorm(1000,sd=.1)*.2
rawData <- list()
rawData$x <- c(x1,x2)
rawData$y <- c(y1,y2)

#Affine transformation
normData <- normalizeIllumina(rawData,plot=FALSE,verbose=TRUE)

\dontrun{
#Affine transformation with plotting
dev.new()
normOpts <- setNormOptions(minSize=10)
normData <- normalizeIllumina(rawData,normOpts=normOpts,plot=TRUE,verbose=TRUE)

#After rotation and shearing
dev.new()
plot(normData$x,normData$y,pch='.',main='Affine transformation',xlab='R',ylab='G')
abline(v=0,h=0,col='blue')
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
