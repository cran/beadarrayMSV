\name{generatePolyCenters}
\Rdversion{1.1}
\alias{generatePolyCenters}
\title{
  Generate list of possible genotype categories
}
\description{
  Generates a list of all possible genotype categories for a specific
  ploidy, including the theoretic allele ratios
}
\usage{
generatePolyCenters(ploidy)
}
\arguments{
  \item{ploidy}{
    One of \dQuote{di}, \dQuote{tetra}, or \dQuote{tetra.red}. The first
    allows only monomorphics and SNPs, the second allows PSVs and MSVs
    as well. The option \dQuote{tetra.red} is the same as \dQuote{tetra}, except
    \dQuote{MSV-5} is not included. This may be used (especially for small samples)
    if many false positive MSV-5 markers are found, and a more
    restricted classification is needed
}
}
\details{
  Usually called by other functions
}
\value{
  List including
  \item{centers }{List of possible B allele ratios for each cluster category}
  \item{classification }{List of possible cluster categories}
  \item{size }{Numeric vector with the maximum number of clusters within
    each category}
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
\author{
  Lars Gidskehaug
}
%\note{
%}
\seealso{
  \code{\link{callGenotypes}}, \code{\link{getCenters}},
  \code{\link{testHardyWeinberg}}, \code{\link{plotGenotypes}} 
}
\examples{
#For genotype calling of tetraploid genomes
polyCent <- generatePolyCenters(ploidy='tetra')
print(polyCent$classification)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
