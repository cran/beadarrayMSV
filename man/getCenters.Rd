\name{getCenters}
\Rdversion{1.1}
\alias{getCenters}
\alias{getSpecificCenters}
\title{
  Estimate starting points for clustering
}
\description{
  One or several starting points for one or more genotype categories are
  estimated, given genotype data for a single marker
}
\usage{
getCenters(theta, gO = setGenoOptions(),
    breaks = seq(-0.25, 1.25, gO$binWidth),
    polyCent = generatePolyCenters(ploidy = gO$ploidy))

getSpecificCenters(theta, classification, gO = setGenoOptions(),
    breaks = seq(-0.25, 1.25, gO$binWidth),
    polyCent = generatePolyCenters(ploidy = gO$ploidy))
}
\arguments{
  \item{theta}{
    Numeric vector of \dQuote{theta}-values for a marker, as given in
    the \code{assayData} slot of
    \code{"\linkS4class{AlleleSetIllumina}"} objects
  }
  \item{gO}{
    List of genotype calling options. See \code{\link{setGenoOptions}}
  }
  \item{breaks}{
    Histogram breakpoints. See \code{\link{hist}}
  }
  \item{polyCent}{
    List of all possible genotype categories with initial centre points
    for the clustering. See \code{\link{generatePolyCenters}}
  }
  \item{classification}{
    Character string with a single genotype category
  }
}
\details{
  Usually called from within other functions. The purpose of
  \code{getCenters} is to suggest a few of the most likely cluster
  categories and corresponding starting points in ranked order. The
  function \code{\link{getSpecificCenters}} returns starting points for
  a given genotype category
}
\value{
  The function \code{getCenters} returns a ranked list with elements
  \item{ix }{Numeric vector with index to categories returned from
    \code{\link{generatePolyCenters}}}
  \item{centers }{List of initial centre points of clusters in
    \dQuote{theta}-dimension}\cr
  The function \code{getSpecificCenters} returns a numeric vector of
  clustering starting values
}
\author{
  Lars Gidskehaug
}
\note{
  For \code{ploidy="tetra"}, the function has been empirically tuned to
  find good starting point for each marker by calling
  \code{\link{findClusters}} repeatedly. Other ploidy has not been
  implemented, but the function will return non-ranked genotype
  categories with centre points corresponding to theoretical B allele
  ratios. A warning will be issued to alert the user that the
  suggested centre points are not optimized or ranked in any way
}

\seealso{
  \code{\link{findClusters}}, \code{\link{callGenotypes}}
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

#Suggest some candidate categories with initial centre points
ind <- 2
sConf <- getCenters(assayData(BSRed)$theta[ind,],gO=gO,polyCent=polyCent))
print(sConf)
print(polyCent$classification[sConf$ix])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
