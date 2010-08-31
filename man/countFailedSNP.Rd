\name{countFailedSNP}
\Rdversion{1.1}
\alias{countFailedSNP}
\title{
  Calculate ratio of called markers for each array
}
\description{
  Not counting markers classified as \dQuote{FAIL} or \dQuote{MONO-filt},
  calculate the ratio of markers that are called for each array
}
\usage{
countFailedSNP(BSRed, inclPedErrors = TRUE)
}
\arguments{
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object containing an
    \code{assayData} entry \dQuote{call} (see
    \code{\link{callGenotypes}}) 
  }
  \item{inclPedErrors}{
    If \code{TRUE}, calls violating pedigree count as missing
  }
}
\details{
  In order to include pedigree errors, \code{BSRed} must have an
  \code{assayData} entry \code{ped.check} (see
  \code{\link{validateCallsPedigree}})
}
\value{
  An \code{"\linkS4class{AlleleSetIllumina}"} object with an added
  \code{phenoData} column \dQuote{passRatio}. This is a numeric vector
  holding the ratio of non-missing calls for each array
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
\author{
  Lars Gidskehaug
}
\note{
  This function may be used to discard arrays with a low number of
  called markers. Note however that an array may be valuable even if the
  sample falls just outside the cluster borders for many markers (e.g. for a
  high intensity array). Should therefore be used with caution
}
\seealso{
  \code{\link{callGenotypes}}, \code{\link{validateCallsPedigree}}
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

#Genotype calling
BSRed <- callGenotypes(BSRed)
BSRed <- validateCallsPedigree(BSRed)
BSRed <- countFailedSNP(BSRed,inclPedErrors=TRUE)
print(range(pData(BSRed)$passRatio))

#Plot highlighting markers to be discarded
#NB! Such a high passRatio is not recommended
indGoodArrays <- pData(BSRed)$passRatio > 0.6
plotGenotypes(BSRed,indHighlight=which(!indGoodArrays))
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
