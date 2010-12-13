\name{scatterArrays}
\Rdversion{1.1}
\alias{scatterArrays}
\title{
  Cartesian scatter-plots of two-colour intensities
}
\description{
  Scatter-plots for a series of arrays are produced. Which intensities
  are plotted depends on whether the input \code{BSData} is an instance of
  \code{"\linkS4class{BeadSetIllumina}"} or \code{"\linkS4class{AlleleSetIllumina}"}
}
\usage{
scatterArrays(BSData, arrays, markers = seq(1, nrow(BSData), 5),
    smooth = TRUE, newFigure = TRUE, maxPlots = 72, ...)
}
\arguments{
  \item{BSData}{
    \code{"\linkS4class{BeadSetIllumina}"} object (intensities
    \dQuote{G} vs. \dQuote{R} are plotted) or\cr
    \code{"\linkS4class{AlleleSetIllumina}"} object (intensities
    \dQuote{B} vs. \dQuote{A} are plotted)
  }
  \item{arrays}{
    Indexes to arrays
  }
  \item{markers}{
    Indexes to markers
  }
  \item{smooth}{
    If \code{TRUE}, density-plots are used (see \code{\link{smoothScatter}})
  }
  \item{newFigure}{
    Logical indicating whether or not to clear the current device before
    plotting. If \code{FALSE}, an error will be produced if more than
    one array is specified.
  }
  \item{maxPlots}{
    Numeric indicating the maximum allowed number of arrays to
    plot. Exceeding this limit will produce an error.
  }
  \item{\dots}{
    Additional graphical input parameters
  }
}
\value{
  This function is called for its side effects
}
\author{
  Lars Gidskehaug
}

\seealso{
\code{\linkS4class{BeadSetIllumina}},
\code{\linkS4class{AlleleSetIllumina}},
\code{\link{plotPreprocessing}}, 
\code{\link{plotGenotypes}} 
}
\examples{
\dontrun{
#Read a BeadSetIllumina object using files in example data directory
rPath <- system.file("extdata", package="beadarrayMSV")
BSDataRaw <- readBeadSummaryOutput(path=rPath,recursive=TRUE)

## Plot G vs. R
dev.new()
scatterArrays(BSDataRaw,smooth=FALSE)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{hplot}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
