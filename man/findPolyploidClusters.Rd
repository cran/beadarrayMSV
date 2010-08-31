\name{findPolyploidClusters}
\Rdversion{1.1}
\alias{findPolyploidClusters}
\title{
  K-means clustering
}
\description{
  Wrapper for \code{\link{kmeans}}, allows samples of low presicion to
  be left out from the clustering and subsequently assigned to clusters
}
\usage{
findPolyploidClusters(X, indSE = rep(TRUE, nrow(X)), centers,
    plot = FALSE, wss.update = TRUE, ...)
}
\arguments{
  \item{X}{
    Matrix with data for a single marker to be clustered, with three
    columns holding \dQuote{theta}, \dQuote{intensity}, and \dQuote{SE}
    vectors (in that order) as from the \code{assayData} slot of an
    \code{"\linkS4class{AlleleSetIllumina}"} object
  }
  \item{indSE}{
    Logical vector of indexes to samples on which to base the clustering
  }
  \item{centers}{
    Numeric vector with \dQuote{theta} starting values for the clustering
  }
  \item{plot}{
    If \code{TRUE}, histogram with bins encompassing the initial centre
    points is plotted
  }
  \item{wss.update}{
    The within-cluster sums of squares are returned from
    \code{\link{kmeans}} but not actually used in the genotype
    calling. If \code{FALSE}, time is saved by not recalculating the
    sums of squares after including initially left-out samples in the
    clusters
  }
  \item{\dots}{
    Additional arguments to \code{\link{hist}}
  }
}
\details{
  Usually called from within the function \code{\link{callGenotypes}} or
  relatives. There the column of intensities is scaled with twice its
  median value times a scaling factor \dQuote{rPenalty} (see
  \code{\link{setGenoOptions}}) to ensure (by default) relatively higher
  weight to the \dQuote{theta} dimension during clustering. 
  
  All samples left out from the clustering are subsequently incorporated
  into the clusters. By leaving out samples of low precision, the
  resulting clusters may be more accurate.
}
\value{
  Object of class \code{"\link{kmeans}"}
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
  The \dQuote{Hartigan-Wong} algorithm (see
  \code{\link{kmeans}}) is used by default, however this 
  method returns an error if no points are closest to one or more
  centres. If such an error is returned it will be catched, and a second
  attempt at clustering will be performed using the \dQuote{MacQueen}
  algorithm. A warning will be issued in those cases
}
\seealso{
  \code{\link{callGenotypes}}, \code{\link{getCenters}}, \code{\link{kmeans}}
}
\examples{
\dontrun{
#Read pre-processed data directly into AlleleSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
normOpts <- setNormOptions()
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],markers=1:10,beadInfo=beadInfo)

#Generate list of marker categories
gO <- setGenoOptions()
polyCent <- generatePolyCenters(ploidy=gO$ploidy)
print(polyCent)

#Estimate list of likely center points for an MSV-5 marker
ind <- 2
dev.new(); par(mfrow=c(3,1),mai=c(.5,.5,.5,.1))
polyCl <- findClusters(assayData(BSRed)$theta[ind,],
    breaks=seq(-0.25,1.25,0.04),plot=TRUE)
print(polyCl)

#Clustering using all samples
sclR <- median(assayData(BSRed)$intensity[ind,],na.rm=TRUE)*ind*gO$rPenalty
X <- matrix(cbind(assayData(BSRed)$theta[ind,],
                  assayData(BSRed)$intensity[ind,]/sclR,
                  assayData(BSRed)$SE[ind,]),ncol=3)
clObj <- findPolyploidClusters(X,centers=polyCl$clPeaks,plot=TRUE)
plot(X[,1],X[,2],col=clObj$cluster)
print(clObj)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
