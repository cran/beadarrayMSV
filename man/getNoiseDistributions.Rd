\name{getNoiseDistributions}
\Rdversion{1.1}
\alias{getNoiseDistributions}
\alias{plotEstimatedNoise}
\title{
  Estimate median and robust spread of background noise
}
\description{
  The genotypes of [A/T] and [C/G] markers are measured with Infinium I
  beads using an arbitrary (red or green) channel, and the alternate
  channel measures noise only. The median and median absolute deviation
  (mad) of each noise channel is estimated and returned for each array
}
\usage{
getNoiseDistributions(BSData, subBeadPool = NULL, normInd,
    normOpts = setNormOptions(), plot = FALSE, newFigure = plot,
    maxPlots = 72, xlim = NULL, ...)

plotEstimatedNoise(BSData, noiseDist,
    normInd = rep(TRUE, nrow(BSData)), normOpts = setNormOptions(),
    newFigure = TRUE, maxPlots = 72, ...)
}
\arguments{
  \item{BSData}{
    \code{"\linkS4class{BeadSetIllumina}"} object, previously subjected to
    rotation and shearing but not to log- or nth-root transformation.
  }
  \item{subBeadPool}{
    Vector of one or more 1-digit integers (of class character or numeric)
    denoting sub-bead pool(s) to base estimations upon. For
    \code{subBeadPool = "x"}, the red channel noise is estimated based 
    on markers with \code{featureData} column \code{Norm.ID = "20x"} and the green channel noise
    is based on markers with \code{Norm.ID = "10x"}. For these channels
    and markers, only noise is detected. If more than one
    integer is given, the full set of Infinium I markers corresponding
    to the specified sub-bead pools is used. If \code{NULL}, all
    Infinium I markers are used (default).
  }
  \item{normInd}{
    Matrix with logical indexes to sub-bead pool for each bead-type. See
    \code{\link{getNormInd}} 
  }
  \item{normOpts}{
    List specifying pre-processing settings. See \code{\link{setNormOptions}}
  }
  \item{plot}{
    If \code{TRUE}, a the estimated and parametrized noise for each
    channel is plotted
  }
  \item{newFigure}{
    Logical indicating whether or not to clear the current device before
    plotting. If \code{FALSE}, an error will be produced if more than
    one array is specified
  }
  \item{maxPlots}{
    Numeric indicating the maximum allowed number of arrays to
    plot. Exceeding this limit will produce an error.
  }
  \item{xlim}{
    Range of x-axis
  }
  \item{\dots}{
    Additional arguments to \code{plot}
  }
  \item{noiseDist}{
    Matrix output from \code{getNoiseDistribution}
  }
}
\details{
  Usually called by \code{\link{preprocessBeadSet}}.

  There are three main groups of markers, as identified by the
  \code{featureData} column \dQuote{Norm.ID} of \code{BSData}. Those
  identified by a single digit \dQuote{x} are Infinium II beads, and those
  identified by three digits \dQuote{10x} and \dQuote{20x} are Infinium
  I beads. The difference between the latter is that \dQuote{10x} beads
  are measured using the red channel only, whereas \dQuote{20x} beads
  are measured with the green channel only. The background noise can
  thus be estimated based on the alternate channel.
}
\value{
  \code{getNoiseDistribution} returns a matrix (\code{noiseDist})
  holding the median and mad for both channels, all arrays

  \code{plotEstimatedNoise} is used for its side effects
}
\author{
  Lars Gidskehaug
}
\note{
  Sub-bead pools with different 1-digit identifiers \dQuote{x} are
  pooled together whenever more than a single sub-bead pool is given
}
\section{Warning }{
  Both these functions take non-transformed \code{BSData} as input,
  however transformations are performed inside the functions as
  specified in \code{normOpts}. It follows that \code{noiseDist} holds
  the median and mad of \emph{transformed} data. Use
  \code{plotEstimatedNoise} with caution, as one input parameter is
  transformed and another is not. The function 
  \code{\link{plotPreprocessing}} may be a good alternative
}
\seealso{
\code{\link{preprocessBeadSet}}, \code{\link{plotPreprocessing}}
}
\examples{
\dontrun{
#Read files into BeadSetIllumina-object
rPath <- system.file("extdata", package="beadarrayMSV")
BSDataRaw <- readBeadSummaryOutput(path=rPath,recursive=TRUE)

#Find indexes to sub-bead pools
beadInfo <- read.table(paste(rPath,'beadData.txt',sep='/'),sep='\t',
    header=TRUE,as.is=TRUE)
rownames(beadInfo) <- make.names(beadInfo$Name)
normInd <- getNormInd(beadInfo,featureNames(BSDataRaw))

#Pre-process
normOpts <- setNormOptions(minSize=50,breaks=200)
BSData <- shearRawSignal(BSDataRaw, normOpts = normOpts,plot=TRUE)
noiseDist <- getNoiseDistributions(BSData[,1:4], normInd = normInd,
    normOpts = normOpts, plot = TRUE)
print(noiseDist)
plotEstimatedNoise(BSData,noiseDist,normOpts=normOpts)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
