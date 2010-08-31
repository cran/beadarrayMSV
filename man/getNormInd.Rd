\name{getNormInd}
\Rdversion{1.1}
\alias{getNormInd}
\title{
  Retrieve sub-bead pool indexes
}
\description{
  Creates an array of logical indexes to each bead-type for use in normalization
}
\usage{
getNormInd(beadInfo, featureNames, normID = NULL, verbose = TRUE)
}

\arguments{
  \item{beadInfo}{
    Data-frame containg data on each marker in the experiment,
    specifically the \dQuote{Address}, \dQuote{Address2}, and
    \dQuote{Norm.ID} connecting beads to markers (usually exported from
    Illumina's GenomeStudio Genotyping Module)
  }
  \item{featureNames}{
    Character vector with bead-type names (addresses)
  }
  \item{normID}{
    Character vector with one or more sub-bead pool indexes. If
    \code{NULL}, all \code{Norm.ID}'s found in \code{beadInfo} are used
  }
  \item{verbose}{
    If \code{TRUE}, the sum of each sub-bead pool is printed
  }
}
%\details{
%}
\value{
  Matrix of size (\code{length(featureNames)} x \code{length(normID)}),
  with logical indices to the sub-bead pool to which each bead-type belongs
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
  Beads manufactured in different pools should be normalised separately
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{preprocessBeadSet}}, \code{\link{getNoiseDistributions}}
}
\examples{
\dontrun{
#Common use includes BeadSetIllumina-object
rPath <- system.file("extdata", package="beadarrayMSV")
BSDataRaw <- readBeadSummaryOutput(path=rPath,recursive=TRUE)
beadInfo <- read.table(paste(rPath,'beadData.txt',sep='/'),sep='\t',
    header=TRUE,as.is=TRUE)
rownames(beadInfo) <- make.names(beadInfo$Name)
normInd <- getNormInd(beadInfo,featureNames(BSDataRaw))
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
