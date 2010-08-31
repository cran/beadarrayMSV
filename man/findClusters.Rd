\name{findClusters}
\Rdversion{1.1}
\alias{findClusters}
\title{
  Suggest clusters based on histograms
}
\description{
  Initial cluster centres are suggested based on the \dQuote{theta}
  values of a single marker. Usually called by \code{\link{getCenters}}
  or \code{\link{getSpecificCenters}}
}
\usage{
findClusters(theta, breaks = seq(-0.25, 1.25, 0.05), minBin = 2,
    plot = FALSE)
}
\arguments{
  \item{theta}{
    Numeric vector of polar coordinates angles for a single marker, as
    given in the \code{assayData} slot \dQuote{theta} of objects of
    class \code{"\linkS4class{AlleleSetIllumina}"}
  }
  \item{breaks}{
    Histogram breakpoints. See \code{\link{hist}}
  }
  \item{minBin}{
    The minimum peak height below which peaks are set to zero
  }
  \item{plot}{
    If \code{TRUE}, histogram is plotted (for testing)
  }
}
%\details{
%}
\value{
  A list containing
  \item{clPeaks }{Suggested cluster centres}
  \item{clSizes }{Estimated number of samples in each cluster}
  \item{nCl }{Number of clusters}
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
  This is a \dQuote{quick and dirty} way of estimating cluster
  centres. The function \code{\link{getCenters}} is used as a wrapper to
  \code{findClusters} and returns interpreted output after calling the
  latter function several times with different arguments
}
\seealso{
  \code{\link{getCenters}}, \code{\link{getSpecificCenters}},
  \code{\link{createAlleleSet}}
}
\examples{
\dontrun{
#Read pre-processed data directly into AlleleSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],markers=1:10,beadInfo=beadInfo)

#Tune resolution or filter to achieve monomorphic marker
print(findClusters(assayData(BSRed)$theta[1,],plot=TRUE))
print(findClusters(assayData(BSRed)$theta[1,],breaks=seq(-0.25,1.25,0.1),plot=TRUE))
print(findClusters(assayData(BSRed)$theta[1,],minBin=5,plot=TRUE))

#Tune resolution to achieve MSV-5 call
par(mfrow=c(3,1),mai=c(.5,.5,.5,.1))
plot(assayData(BSRed)$theta[2,],assayData(BSRed)$intensity[2,],pch='o')
print(findClusters(assayData(BSRed)$theta[2,],plot=TRUE))
print(findClusters(assayData(BSRed)$theta[2,],breaks=seq(-0.25,1.25,0.04),plot=TRUE))
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
