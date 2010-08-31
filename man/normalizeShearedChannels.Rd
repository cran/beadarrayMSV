\name{normalizeShearedChannels}
\Rdversion{1.1}
\alias{normalizeShearedChannels}
\title{
  Channel normalization
}
\description{
  Normalizes the red and green channels of each array
}
\usage{
normalizeShearedChannels(trChannel, noiseDist,
    normOpts = setNormOptions())
}
\arguments{
  \item{trChannel}{
    A list with at least two matrices, \dQuote{X} and \dQuote{Y},
    containing red and green intensities, respectively. The dimensions of
    the matrices are (markers x samples)
  }
  \item{noiseDist}{
    A matrix of dimension (samples x 4), containing the estimated median
    and mad of each channel. See \code{\link{getNoiseDistributions}}
  }
  \item{normOpts}{
    List of pre-processing settings. See \code{\link{setNormOptions}}
  }
}
\details{
  Depending on \code{normOpts$method}, the channels on each array are
  \dQuote{quantile}, \dQuote{medianAF}, or \dQuote{linPeak}
  normalized (see \code{\link{setNormOptions}}). For quantile
  normalization, the \pkg{limma} package (Smyth and Speed, 2003) is used
  (see \code{\link{normalizeQuantiles}}). For \dQuote{medianAF}, the red channel is
  scaled such that \code{median(R/(R+G))} is close to one half. This is
  similar to the normalization suggested in Macgregor \emph{et al.}
  (2008). If \dQuote{linPeak} is chosen, both channels are linearly
  scaled by the quantile defined in \code{normOpts$scale}.
}
\value{
  A list similar to \code{trChannel} is returned with normalized data. A
  character string \dQuote{method} is added to the list describing the
  normalization performed
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
  
  S. Macgregor \emph{et al.} (2008) Highly cost-efficient genome-wide
  association studies using DNA pools and dense SNP
  arrays. \emph{Nucleic Acids Res.} \bold{36}(6):e35
  
  G. K. Smyth and T. P. Speed (2003) Normalization of cDNA
  microarray data. \emph{Methods} \bold{31}:265-27
}
\author{
  Lars Gidskehaug
}
\note{
  Though quantile normalization is often reported to work well, it represents a
  quite drastic form of manipulation of the data. It assumes that any
  difference in distribution between the channels is related to
  technical measurement error rather than biological variation. By
  forcing the data into identical distributions, there is a risk that
  some samples are forced into wrong clusters in the subsequent genotype
  calling. We therefore advice to use quantile normalization with
  caution, and only if it is seen to have a good effect on subsequent
  clustering.
}

\seealso{
\code{\link{preprocessBeadSet}}, \code{\link{normalizeQuantiles}}
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

#Pre-process 1 array
normOpts <- setNormOptions(minSize=10)
BSData <- shearRawSignal(BSDataRaw, normOpts = normOpts)
noiseDist <- getNoiseDistributions(BSData, normInd = normInd,
    normOpts = normOpts)
trChannel <- transformChannels(assayData(BSData)$R,
    assayData(BSData)$G, normOpts = normOpts)
mafData <- normalizeShearedChannels(trChannel, noiseDist,
    normOpts = normOpts)
quantData <- normalizeShearedChannels(trChannel, noiseDist,
    normOpts = setNormOptions(method='quantNorm'))

#Plot distributions
dev.new()
par(mfrow=c(3,2))
hist(trChannel$X,breaks=30,col='red',main='Red channel')
hist(trChannel$Y,breaks=30,col='green',main='Green channel')
hist(mafData$X,breaks=30,col='red',main='medianAF')
hist(mafData$Y,breaks=30,col='green',main='medianAF')
hist(quantData$X,breaks=30,col='red',main='quantNorm')
hist(quantData$Y,breaks=30,col='green',main='quantNorm')
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
