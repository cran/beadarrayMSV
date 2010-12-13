\name{makeDiploidCalls}
\Rdversion{1.1}
\alias{makeDiploidCalls}
\title{
  Constrain calls to diploid representation
}
\description{
  Input calls for any diploid or tetraploid genome marker are restricted
  to diploid representation. This implies that non-segregating
  paralogs are ignored or set to missing, and non-resolvable paralogs
  are set to missing
}
\usage{
makeDiploidCalls(calls, fData)
}
\arguments{
  \item{calls}{
    Numerical matrix with dimensions (markers x samples). The allele
    ratios are from the set \{0, 1/4, 1/2, 3/4, 1\} 
  }
  \item{fData}{
    \code{featureData} data-table such as from an
    \code{"\linkS4class{AlleleSetIllumina}"} object, with rows corresponding to
    rows in \code{calls} and containing the column
    \dQuote{Classification} (see \code{\link{callGenotypes}}). A column
    \dQuote{Manual.Calls.R} will be used if present (see
    \code{\link{callGenotypes.interactive}}) 
  }
}
\details{
  Usually called by the function \code{\link{translateTheta}}
}
\value{
  A numerical matrix with the same dimensions as \code{calls}, however
  with values restricted to \{0, 1/2, 1\}
}
\author{
  Lars Gidskehaug
}
\seealso{
  \code{\link{translateTheta}}, \code{\linkS4class{AlleleSetIllumina}}
}
\examples{
#Construct tiny example data
calls <- c(0,.5,1,0,.25,.5,.5,.75,1,.5,.5,.5,0,.25,.75)
categories <- c('SNP','MSV-a','MSV-b','PSV','MSV-5')
calls <- matrix(calls,nrow=5,byrow=TRUE,
    dimnames=list(categories,paste('S',1:3,sep='')))
fData <- data.frame(Classification=categories,row.names=categories)
print(calls)

#Make diploid
diploidCalls <- makeDiploidCalls(calls, fData)
print(diploidCalls)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
