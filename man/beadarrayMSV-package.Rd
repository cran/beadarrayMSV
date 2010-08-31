\name{beadarrayMSV-package}
\Rdversion{1.1}
\alias{beadarrayMSV-package}
\alias{beadarrayMSV}
\docType{package}
\title{
  beadarrayMSV: Package for analysis of high-throughput Illumina BeadArrays
}
\description{
  Functions for reading, pre-processing and analyzing Illumina BeadArray
  data, in particular from the Infinium platforms. Methods for
  clustering and genotype calling of multisite variancs (MSVs) from
  polyploid genomes are provided. Paralogs may be resolved and mapped to
  individual chromosomes
}
\details{
\tabular{ll}{
Package: \tab \pkg{beadarrayMSV}\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2010-01-09\cr
License: \tab GPL (>=2)\cr
LazyLoad: \tab yes\cr
LazyData: \tab no\cr
Depends: \tab R (>= 2.10.0), Biobase (>= 2.5.5), methods, geneplotter\cr
Imports: \tab rggobi, limma\cr
SystemRequirements: \tab GGobi
}
Two classes, \code{"\linkS4class{BeadSetIllumina}"} and
\code{"\linkS4class{AlleleSetIllumina}"}, are defined for holding and
working with genetic data.

Illumina BeadArray summary-data are loaded using the function
\code{\link{readBeadSummaryOutput}}, and pre-processed using
\code{\link{preprocessBeadSet}}.

Automatic clustering and genotype calling is performed using
\code{\link{callGenotypes}}, and validated using
\code{\link{validateCallsPedigree}} and \code{\link{plotGenotypes}}.

Manual clustering with \code{\link{callGenotypes.interactive}}, which
benefits from the interactive graphics package \pkg{rggobi}. Often used in
combination with \code{\link{assignToAlleleSet}}.

Reading and writing data from and to files with the functions
\code{\link{createAlleleSetFromFiles}} and
\code{\link{writeAlleleSet}}.

For splitting MSV-5 markers into individual paralogs and assigning them to
chromosomes, use \code{\link{assignParalogues}}.
}
\author{
Lars Gidskehaug

Maintainer: Lars Gidskehaug <\email{lars.gidskehaug@umb.no}>
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
%~~ Optionally other standard keywords, one per line, from file KEYWORDS in ~~
%~~ the R documentation directory ~~
\keyword{ package }
%\seealso{
%~~ Optional links to other man pages, e.g. ~~
%~~ \code{\link[<pkg>:<pkg>-package]{<pkg>}} ~~
%}
%\examples{
%~~ simple examples of the most important functions ~~
%}
