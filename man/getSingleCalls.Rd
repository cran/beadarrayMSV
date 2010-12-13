\name{getSingleCalls}
\Rdversion{1.1}
\alias{getSingleCalls}
\title{
  Identify MSV-5 paralogs with equal genotypes
}
\description{
  Identifies MSV-5 markers for which both paralogs are either
  \dQuote{AA}, \dQuote{BB}, or \dQuote{AB}
}
\usage{
getSingleCalls(BSRed)
}
\arguments{
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} (or
    \code{"\linkS4class{MultiSet}"}) object containing only
    MSV-5 markers, with an \code{assayData} entry \dQuote{call} (see
    \code{\link{callGenotypes}}) and a \code{phenoData} column
    \dQuote{PedigreeID}. The latter contains strings
    <p><mmm><fff><oo>, where \dQuote{p}, \dQuote{mmm},
    \dQuote{fff}, and \dQuote{oo} are unique identifiers for population, 
    mother, father, and individual within full-sib group,
    respectively. \dQuote{000} means founding parent, whereas
    \dQuote{999} means unknown parent
  }
}
\details{
  For use in other functions, such as \code{\link{unmixParalogues}} and
  \code{\link{assignParalogues}}. May be called initially by user in
  order to save time in the subsequent calculations. All monomorphic
  markers [\dQuote{AA},\dQuote{AA}] and [\dQuote{BB},\dQuote{BB}], as
  well as parental markers with genotype [\dQuote{AB},\dQuote{AB}] are
  identified. 
}
\value{
  Matrix of size \code{dim(BSRed)} containing calls in \{0, 1/2, 1\} for
  the markers in question, \code{NA} otherwise
}
\author{
  Lars Gidskehaug
}

\seealso{
  \code{\link{unmixParalogues}}, \code{\link{assignParalogues}},
  \code{\linkS4class{AlleleSetIllumina}}, \code{\link{callGenotypes}}
}
\examples{
\dontrun{
#Read markers into an AlleleSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
normOpts <- setNormOptions()
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],beadInfo=beadInfo)

#Genotype calling and selection of some MSV-5s
BSRed <- callGenotypes(BSRed)
BSRed <- validateCallsPedigree(BSRed)
iMSV5 <- fData(BSRed)$Classification \%in\% 'MSV-5' &
    fData(BSRed)$Ped.Errors \%in\% 0
plotGenotypes(BSRed,markers=which(iMSV5))

#Find markers in question and compare
singleCalls <- getSingleCalls(BSRed[iMSV5,])
print(assayData(BSRed)$call[iMSV5,1:4])
print(singleCalls[,1:4])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
