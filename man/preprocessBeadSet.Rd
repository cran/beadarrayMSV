\name{preprocessBeadSet}
\Rdversion{1.1}
\alias{preprocessBeadSet}
\alias{setNormOptions}
\alias{plotPreprocessing}
\title{
  Pre-processing of BeadSetIllumina objects
}
\description{
  Performs a sequence of pre-processing routines on objects of class
  \code{"\linkS4class{BeadSetIllumina}"} 
}
\usage{
setNormOptions(shearInf1 = TRUE, transf = "root",
    method = "medianAF",
    minSize = suggestSh(shearInf1)$minSize,
    prob = suggestSh(shearInf1)$prob,
    nBins = suggestSh(shearInf1)$nBins,
    dist = suggestTr(transf)$dist,
    pNorm = suggestTr(transf)$pNorm,
    nthRoot = suggestTr(transf)$nthRoot,
    offset = suggestTr(transf)$offset,
    scale = suggestNo(method)$scale,
    nSD = 3, breaks = 200)

plotPreprocessing(BSData, normInd,
    normOpts = setNormOptions(shearInf1 = !is.null(normInd)),
    plotArray = 1, \dots)

preprocessBeadSet(BSData, normInd,
    normOpts = setNormOptions(shearInf1 = !is.null(normInd)))
}
\arguments{
  \item{shearInf1}{
    If \code{TRUE}, only the signal-containing channel of Infinium I
    beads are used to define the homozygote asymptotes for the affine
    transformation (rotation and shearing). This may be more accurate
    than using all beads, as the variation along the perpendicular axis
    is small
  }
  \item{transf}{
    Character string denoting transformation. One of \dQuote{none},
    \dQuote{log} (base 2), or \dQuote{root} (defined by \code{nthRoot})
  }
  \item{method}{
    Character string denoting channel normalization method for each
    array. One of \dQuote{none}, \dQuote{quantNorm}, \dQuote{medianAF},
    or \dQuote{linPeak}. For quantile normalization, the
    \pkg{limma} package is required (Smyth and Speed, 2003). For \dQuote{medianAF}, the
    red channel is scaled such that \code{median(R/(R+G))} is close to
    one half. If \dQuote{linPeak} is chosen, both channels are linearly
    scaled by its \code{scale}'th quantile
  }
  \item{minSize}{
    The homozygote asymptotes are found by drawing a straight line
    through quantile points distributed in bins along each axis. Only
    bins containing more than \code{minSize} points are used
  }
  \item{prob}{
    Numeric probabiliy used in the \code{\link{quantile}}-function,
    defining the points through which the asymptotes are drawn
  }
  \item{nBins}{
    The number of bins into which to divide the points along each axis
    before the homozygote asymptotes are drawn
  }
  \item{dist}{
    Character string defining the  distance measure used for polar
    coordinates transformation of the signal. One of \dQuote{manhattan},
    \dQuote{euclidean}, or \dQuote{minkowski}. See \code{\link{cart2pol}}
  }
  \item{pNorm}{
    See \code{\link{cart2pol}}
  }
  \item{nthRoot}{
    Numeric used together with \code{transf="root"}
  }
  \item{offset}{
    A numeric offset added to each channel before transformation. Values
    below zero are set to \code{NA} during log- or root-transformation
  }
  \item{scale}{
    Used with \code{method="linPeak"}
  }
  \item{nSD}{
    The background signal is estimated as \code{nSD}
    times the estimated standard measurement error (found from the the
    parameterised noise levels for each channel)
  }
  \item{breaks}{
    The parameterisation of noise levels is based on a histogram of each
    channel, where the numeric \code{breaks} defines the smoothing
    (number of bins). See \code{\link{hist}}
  }
  \item{BSData}{
    \code{"\linkS4class{BeadSetIllumina}"} object not previously pre-processed
  }
  \item{normInd}{
    Matrix with logical indexes to sub-bead pool for each bead-type. See
    \code{\link{getNormInd}} 
  }
  \item{normOpts}{
    List output from \code{setNormOptions}
  }
  \item{\dots}{
    Further arguments to \code{\link{plotEstimatedNoise}}
  }
  \item{plotArray}{
    Numeric index to a single array to plot
  }
}
\details{
  Using \code{setNormOptions}, default pre-processing options are
  suggested, and any changes may be specified. The effects of
  different options are studied using \code{plotPreprocessing} for a
  number of arbitrary arrays. This produces four plots; i) raw data
  scatter, ii) scatter including the estimated asymptotes for the affine
  transformation (red/green) including the quantile points used (blue
  dots), iii) the noise levels for the red and green channel after
  transformation, parameterized signal superimposed, based on the
  non-signal channels of Infinium I beads, and iv) scatter after
  transformation including new axes (green) and estimated noise levels
  (red dots).

  For the affine transformation, it is important that enough quantile
  points are included to get reliable asymptotes. If there are few blue
  dots in plot ii), decrease the \code{minSize} option or set
  \code{shearInf1} to \code{FALSE}. If the grey lines in plot iii) are
  too coarse (too few points) to get a good noise-parameterisation,
  increase \code{breaks}. Note also how the noise levels are affected by
  different transformations.

  Pay close regard to how the transformation affects the shapes of the
  clouds in plot iv). Ideally, three well defined clouds protrude from
  the estimated origin, corresponding to the homozygotes which fall on
  the estimated axes and the heterozygotes which fall 45 degrees in
  between. Imagine a rubber band stretched over the ends of the three
  clouds. If the rubber band is straight (no transformation), the
  \dQuote{manhattan} (or 1-norm \dQuote{minkowski}) distance is the best
  option for polar coordinates. If the three points fall on a
  circle, the \dQuote{euclidean} (or 2-norm \dQuote{minkowski}) distance
  is the best option. If the rubber band forms a shape intermediate
  between a circle and a square (e.g. 4th-root transformation), the
  5-norm \dQuote{minkowski} distance or similar may the best choice.
  
  The function \code{preprocessBeadSet} calls several pre-processing
  routines in sequence. First \code{\link{shearRawSignal}} performs
  the affine transformations, then \code{\link{getNoiseDistributions}}
  estimates the distributions of the noise for each channel. Next,
  \code{\link{transformChannels}} transforms the signal, followed by
  transformation of the standard errors of each channel using
  \code{\link{transformSEs}}. In the end,
  \code{\link{normalizeShearedChannels}} performs channel
  normalisation for each array.
}
\value{
  Output from \code{setNormOptions} is a list with pre-processing
  options

  The function \code{plotPreprocessing} is used for its side effects
  
  Output from \code{preprocessIllumina} is a
  \code{"\linkS4class{BeadSetIllumina}"} object with pre-processed
  \code{assayData} entries. A column \dQuote{noiseIntensity} is added to
  \code{phenoData}, this is the (parameterized) standard error times
  \code{nSD}
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}\cr
  
  G. K. Smyth and T. P. Speed. (2003) Normalization of cDNA
  microarray data. \emph{Methods} \bold{31}:265-27
}
\author{
  Lars Gidskehaug
}
\note{
  If \code{BSData} contains a \code{phenoData} column
  \dQuote{noiseIntensity}, \code{preprocessBeadSet} assumes the data are
  already normalized and an error is produced
}
\seealso{
  \code{\link{readBeadSummaryOutput}}, \code{\link{getNormInd}},
  \code{\link{shearRawSignal}}, \code{\link{getNoiseDistributions}},
  \code{\link{transformChannels}}, \code{\link{transformSEs}},
  \code{\link{normalizeShearedChannels}}, \code{\link{createAlleleSet}},
  \code{\linkS4class{BeadSetIllumina}}
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
normOpts <- setNormOptions(minSize=10)
plotPreprocessing(BSDataRaw,normInd,normOpts,plotArray=1)
BSData <- preprocessBeadSet(BSDataRaw,normInd,normOpts)
pData(BSData)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
