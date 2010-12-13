\name{manualCall}
\Rdversion{1.1}
\alias{manualCall}
\title{
  Interactive calling of genotype for single marker
}
\description{
  Function usually called from within
  \code{\link{callGenotypes.interactive}}, in order to define clusters
  by clicking and dragging with the mouse
}
\usage{
manualCall(marker, cntIdeal, classification, gg = NULL, close.gg = TRUE)
}
\arguments{
  \item{marker}{
    Data-frame containing the columns \dQuote{Theta}, \dQuote{R}, and
    optionally \dQuote{PedCheck} and \dQuote{PedigreeID} for a single
    marker. The first two correspond to \code{assayData} entries
    \dQuote{theta} and \dQuote{intensity} of an
    \code{"\linkS4class{AlleleSetIllumina}"} object. The \dQuote{PedCheck}
    column corresponds to the output from
    \code{\link{validateSingleCall}}. The \dQuote{PedigreeID} consists of 
    strings <p><mmm><fff><oo>, where \dQuote{p},
    \dQuote{mmm}, \dQuote{fff}, and \dQuote{oo} are unique identifiers
    for population, mother, father, and individual within full-sib
    group, respectively. \dQuote{000} means founding parent, whereas
    \dQuote{999} means unknown parent. May also include a vector of B
    allele ratios \dQuote{Call} with results from a previous clustering,
    in which case this is used as starting values
  }
  \item{cntIdeal}{
    A numeric vector of the allowed B allele ratios for a specific genotype category (see
    \code{\link{generatePolyCenters}}) 
  }
  \item{classification}{
    Character string denoting genotype category (see
    \code{\link{generatePolyCenters}})
  }
  \item{gg}{
    An instance of \code{"\link{ggobi}"}
  }
  \item{close.gg}{
    If \code{TRUE}, an updated data-frame \code{marker} is returned and
    \code{gg} is closed. Otherwise, \code{gg} is returned directly
  }
}
\details{
  A \dQuote{GGobi} interactive scatter-plot is produced. Round dots with
  colours purple, pink, red, blue, green and grey denote samples of
  \dQuote{Theta} values 0, 1/4, 1/2, 3/4, 1, and \code{NA},
  respectively. Orange and brown square dots indicate offspring and
  parent pedigree errors, respectively. Select (\dQuote{brush}) points
  by moving around the yellow rectangle visible on the screen using the
  left mouse button. Change the shape of the rectangle using the right
  mouse button.

  If pedigree errors are found after clustering, a warning is issued, and
  the user is given the choice between un-assigning erroneous offspring,
  modifying the clusters, or disregarding the errors. Note that by
  setting erroneous samples to missing, the remaining calls may appear
  better than they are.
}
\value{
  Depending on the value of \code{close.gg}, a data-frame or an object
  of class \code{"\link{ggobi}"} is returned,
  containing marker data including a column \dQuote{Call} with the B
  allele ratio for each subject
}
\author{
  Lars Gidskehaug
}
\seealso{
  \code{\link{ggobi}}, \code{\link{callGenotypes.interactive}}
}
\examples{
\dontrun{
#Read 10 markers into an AlleleSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
normOpts <- setNormOptions()
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],markers=1:10,
    beadInfo=beadInfo)

#Prepare a single marker
ind <- 2
marker <- data.frame(Theta=assayData(BSRed)$theta[ind,],
    R=assayData(BSRed)$intensity[ind,],
    PedigreeID=pData(BSRed)$PedigreeID,
    stringsAsFactors=FALSE)

#Cluster marker from scratch, assuming MSV-5
polyCent <- generatePolyCenters(ploidy="tetra")
iMSV5 <- 7
marker1 <- manualCall(marker,cntIdeal=polyCent$centers[[iMSV5]],
    classification=polyCent$classification[[iMSV5]],close.gg=FALSE)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
