\name{testHardyWeinberg}
\Rdversion{1.1}
\alias{testHardyWeinberg}
\title{
  Test for Hardy-Weinberg equilibrium
}
\description{
  For SNP and MSV markers, the sample is tested for being in
  Hardy-Weinberg (HW) equilibrium. Estimated B allele frequencies are returned
}
\usage{
testHardyWeinberg(sizes, bestConf,
    polyCent = generatePolyCenters(ploidy="di"),
    afList = seq(0, 0.5, 0.05))
}
\arguments{
  \item{sizes}{
    Numeric vector with the size of each cluster in the current genotype category
  }
  \item{bestConf}{
    Character string with genotype category, or numeric index to correct
    genotype category in \code{polyCent}
  }
  \item{polyCent}{
    List with all genotype categories and the allele ratios
    corresponding to the different clusters. See \code{\link{generatePolyCenters}}
  }
  \item{afList}{
    Numeric vector of values within [0, 0.5], denoting which B allele
    frequencies to test in the case of two segregating paralogs (see below)
  }
}
\details{
  The null hypothesis of the test is that the population is in HW
  frequencies. As most populations deviate more or less from HW
  equilibrium, strict control of this test is usually not
  recommended. Still, it can a very powerful test to detect failed
  clustering, by using a sufficiently low significant level to
  account for naturally deviating samples. If the sample contain
  subjects from different populations however, the power of the test may
  be very low.

  At duplicated loci, the observed B allele frequency (BAF) is in 
  fact the mean BAF across both paralogues. For MSV-5 markers, which are
  segregating in both paralogs, the individual BAFs may be estimated
  assuming different candidate values at one paralogue. Several values
  of BAF for one paralogue are set in \code{afList}, such that
  the BAF for the other paralogue is given. A value of \code{0.5} means
  the BAF is the same at both loci. All values are tested for HW, and
  the most likely BAF at both paralogs are those resulting in the
  highest p-value. The accuracy of these estimates increases with the
  degree of HW equilibrium.
}
\value{
  Data-frame with the chi-square test statistic, the degrees of freedom,
  p-value, and both estimated B allele frequencies
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
  \code{\link{callGenotypes}}
}
\examples{
#Arbitrary MSV-5 marker
sizes <- c(30, 200, 1600, 700, 400)
polyCent <- generatePolyCenters(ploidy='tetra')
HWstats <- testHardyWeinberg(sizes,'MSV-5',polyCent=polyCent)
print(HWstats)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
