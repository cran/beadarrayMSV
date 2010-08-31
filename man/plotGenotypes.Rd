\name{plotGenotypes}
\alias{plotGenotypes}
\title{
  Plotting of genotyped markers
}
\description{
  Produces plots of \dQuote{intensity} vs. \dQuote{theta} with clusters
  coloured according to genotype call. Optional highlighting of specified samples
  or of pedigree-errors
}
\usage{
plotGenotypes(BSRed, markers = 1:min(nrow(BSRed), 64),
    indHighlight = NULL, ploidy = "tetra", indicate.SE = FALSE,
    retFrames = FALSE, nC = NULL, mai = NULL, mNoise = NULL,
    main = NULL) 
}
\arguments{
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object
  }
  \item{markers}{
    Index to markers to plot
  }
  \item{indHighlight}{
    Index to samples to highlight with yellow
  }
  \item{ploidy}{
    Character string reflecting the ploidy (copy-number) of the markers,
    defining the appearance of the clusters. Currently, only
    \dQuote{tetra} is implemented
  }
  \item{indicate.SE}{
    If \code{TRUE}, size of points will reflect their precision (1/SE)
  }
  \item{retFrames}{
    If \code{TRUE}, a list of data-frames containing the coordinates for each
    marker is returned
  }
  \item{nC}{
    Number of columns of plots in the figure
  }
  \item{mai}{
    Size of margins. See \code{\link{par}}
  }
  \item{mNoise}{
    The \dQuote{intensity}-limit below which no samples are called. If
    \code{NULL}, the mean \code{pData(BSRed)$noiseIntensity} (across
    arrays) is used
  }
  \item{main}{
    Vector of plot-titles. If \code{NULL}, the \code{featureNames} are used
  }
}
\details{
  All specified markers are plotted in subplots on a single device, and
  no more than 50-100 markers should be plotted at the time. The
  classified samples are coloured according to their allele-ratio, and
  non-called samples are represented as black dots. A red line indicates
  the estimated noise-level.

  There are several ways samples  may be highlighted. If
  \code{indicate.SE} is \code{TRUE}, the size of the dots reflects the
  precision of the intensity-estimates. Else, the samples indicated with
  \code{indHighlight} are represented as yellow dots. If neither of
  these are given, pedigree-errors will be highlighted if such
  information is found in \code{BSRed}. Both \code{assayData} entries
  \dQuote{ped.check.parents} (see
  \code{\link{validateSingleCall}}) and 
  \dQuote{ped.check} (see \code{\link{validateCallsPedigree}}) are
  recognised. Yellow circles and crosses indicate parent and offspring
  errors, respectively. 
}
\value{
  The function \code{plotGenotypes} is called mainly for its side
  effects, however if \code{retFrames} is \code{TRUE} a list of
  data-frames containing the coordinates for each  marker is returned
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
\author{
  Lars Gidskehaug
}

\seealso{
  \code{\link{validateCallsPedigree}}, \code{\link{callGenotypes}}
}
\examples{
\dontrun{
#Read pre-processed data directly into AlleleSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
normOpts <- setNormOptions()
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],beadInfo=beadInfo)

#Genotype calling and plotting
BSRed <- callGenotypes(BSRed)
plotGenotypes(BSRed,1:25)

#Pedigree validation and plotting
BSRed <- validateCallsPedigree(BSRed)
plotGenotypes(BSRed,1:25)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
