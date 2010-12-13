\name{validateCallsPedigree}
\Rdversion{1.1}
\alias{validateCallsPedigree}
\alias{validateSingleCall}
\title{
  Pedigree validation of genotypes
}
\description{
  Checks that genotypes follow basic rules of inheritance
}
\usage{
validateCallsPedigree(BSRed)

validateSingleCall(marker, classification)
}
\arguments{
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object containing an
    \code{assayData} entry \dQuote{call} as well as a \code{featureData}
    column \dQuote{Classification} (see \code{\link{callGenotypes}}), or
    alternatively a column \dQuote{Manual.Calls.R} (see
    \code{\link{callGenotypes.interactive}}). It must also contain a
    \code{phenoData} column \dQuote{PedigreeID}. This contains
    strings <p><mmm><fff><oo>, where \dQuote{p}, \dQuote{mmm},
    \dQuote{fff}, and \dQuote{oo} are unique identifiers for population,
    mother, father, and individual within full-sib group,
    respectively. \dQuote{000} means founding parent, whereas
    \dQuote{999} means unknown parent
  }
  \item{marker}{
    Data frame with at least the columns \dQuote{Call}
    and \dQuote{PedigreeID} for a single marker. The first
    corresponds to the \code{"\linkS4class{AlleleSetIllumina}"} \code{assayData}
    entry \dQuote{call}, the latter is described above.
  }
  \item{classification}{
    Character string with genotype call category for the marker (see
    \code{\link{generatePolyCenters}}) 
  }
}
\details{
  \code{validateCallsPedigree} is usually faster and easier to use
  compared to \code{validateSingleCall}. The latter is more often called
  by other functions, however it has a slightly more detailed outut.
}
\value{
  Output from \code{validateCallsPedigree} is an
  \code{"\linkS4class{AlleleSetIllumina}"} object with an added \code{assayData}
  entry \dQuote{ped.check}. This logical matrix is \code{FALSE} for all
  offspring violating the pedigree information, an all parents are
  \code{NA}
  
  Output from \code{validateSingleCall} is a numeric vector with \{0, 1,
  2\} denoting no error, offspring error, and parent error, respectively
}
\author{
  Lars Gidskehaug
}

\seealso{
  \code{\link{callGenotypes}}, \code{\link{plotGenotypes}}
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

#Genotype calling, pedigree validation and plotting
BSRed <- callGenotypes(BSRed)
BSRed <- validateCallsPedigree(BSRed)
plotGenotypes(BSRed,1:25)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
