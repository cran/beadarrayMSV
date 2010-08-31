\name{locateParalogues}
\Rdversion{1.1}
\alias{locateParalogues}
\alias{plotCountsChrom}
\title{
  Match paralogs with chromosomes
}
\description{
  Matches patterns of parental inherited alleles within half-siblings
  between MSV-5 paralogs and genetic map SNPs. The matches for each
  MSV-5 marker are summed in order to enable mapping of the paralogs to individual
  chromosomes 
}
\usage{
locateParalogues(BSSnp, paraCalls, inheritP, offspringLim = 7,
    ratioLim = 0.9)

plotCountsChrom(chromHits, markers = 1:16, \dots)
}
\arguments{
  \item{BSSnp}{
    \code{"\linkS4class{AlleleSetIllumina}"} (or
    \code{"\linkS4class{MultiSet}"}) object containing only
    SNP markers, with an \code{assayData} entry \dQuote{call} (see
    \code{\link{callGenotypes}}) and a \code{phenoData} column
    \dQuote{PedigreeID}. The latter contains strings
    <p><mmm><fff><oo>, where \dQuote{p}, \dQuote{mmm},
    \dQuote{fff}, and \dQuote{oo} are unique identifiers for population, 
    mother, father, and individual within full-sib group,
    respectively. \dQuote{000} means founding parent, whereas
    \dQuote{999} means unknown parent. It must also contain a
    \code{featureData} column \dQuote{Chr.Name}
  }
  \item{paraCalls}{
    List with two matrix elements \dQuote{father} and \dQuote{mother}
    containing paralogue calls representing paternal and maternal
    inherited alleles in offspring, respectively (see
    \code{\link{unmixParalogues}}) 
  }
  \item{inheritP}{
    List with two matrix elements \dQuote{father} and \dQuote{mother}
    containing genetic map marker calls representing paternal and
    maternal inherited alleles in offspring, respectively (see
    \code{\link{resolveInheritanceSNP}}) 
  }
  \item{offspringLim}{
    In order for a match between a paralogue and a chromosome to be
    detected, the number of (informative) half-siblings must
    equal or exceed this numeric value (see
    \code{\link{setMergeOptions}}) 
  }
  \item{ratioLim}{
    The patterns of paternal and maternal inherited alleles among
    half-sib family offspring are compared between MSV-5 paralogs and
    genetic map SNPs. The ratio of matching allele patterns between the
    two must equal or exceed this numeric value in order for a
    chromosome match to be detected (see
    \code{\link{setMergeOptions}})
   }
  \item{chromHits}{
    A numeric array of size (markers x chromosomes x 2) with the average
    number of matches per chromosome for mothers and fathers
    separately. Part of the output from \code{locateParalogues}.
  }
  \item{markers}{
    Index to subset of MSV-5 markers to plot
  }
  \item{\dots}{
    Additional arguments to \code{\link{axis}}, to be
    used on the x-axes
  }
}
\details{
  The individual paralogs in \code{paraCalls} are associated with the
  genetic map markers in \code{inheritP}. If a matching offspring is
  registered each time an informative allele in the paralogue corresponds
  with an informative allele in the mapped marker, the degree of
  association between the two is determined by counting the 
  number of matches. It is not known whether an \dQuote{A}-allele in the
  paralogue matches with an \dQuote{A}- or \dQuote{B}-allele in the
  tested marker, but the the combination that produces the highest
  number of matches is assumed. This means that any pattern of random
  mis-matches is equally probable as the same number of matches for two
  unlinked loci. The chance of linkage being falsely declared between
  two loci however decreases as the number and ratio of matches
  increase. Associations supported by too few informative meioses are
  therefore filtered away.
  
  There is a 50\% chance of inheriting either allele (\dQuote{A} or
  \dQuote{B}) at any segregating locus, which means that a single match
  is produced by chance 50\% of the times. This gives for instance a
  6/2^5 (19\%) probability that the alleles of two unlinked loci will
  match for four out of five offspring. Also, as we cannot tell
  mis-matches from matches, the probability of a false detection is
  doubled. As such a filter would yield far to many false positives, we
  need to reduce the probability of random associations further. The
  default filter counts only markers with at least \code{offspringLim=7}
  informative meioses and at least \code{ratioLim=90\%}
  matches/mis-matches to the paralogue. This threshold implies a random
  false positive match will occur in 2*11/2^10 (2,1\%) of the tests. The
  total number of matches across markers within each chromosome is
  divided by the number of tested markers, such that the chromosomes
  with the highest average number of matches can be found.

  The plots produced by \code{plotCountsChrom} visualize the average
  scores produced by \code{locateParalogues}. A red (fathers) and
  black (mothers) line is plotted for each MSV-5 marker, with one or two
  peaks indicating the chromosome(s) the paralogs map to.
}
\value{
  The function \code{locateParalogues} returns a list with elements
  \item{cPerMarker }{A numeric array of size (markers x chromosomes x
    2) with the average number of matches per chromosome for mothers and
    fathers separately}
  \item{nCountsTot }{Matrix of size (markers x 2) with the total sum of
    matches per marker for mothers and fathers}\cr
  \code{plotCountsChrom} is used for its side effects
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
  \code{\link{plotCountsChrom}}, \code{\link{setMergeOptions}},
  \code{\link{unmixParalogues}}, \code{\link{resolveInheritanceSNP}},
  \code{\linkS4class{MultiSet}}, \code{\linkS4class{AlleleSetIllumina}},
  \code{\link{assignParalogues}}
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

#Genotype calling and splitting of MSV-5 paralogs
BSRed <- callGenotypes(BSRed)
BSRed <- validateCallsPedigree(BSRed)
iMSV5 <- fData(BSRed)$Classification \%in\% 'MSV-5' &
    fData(BSRed)$Ped.Errors \%in\% 0
paraCalls <- unmixParalogues(BSRed[iMSV5,])

#Genetic map SNPs and inherited parental alleles
iSNP <- fData(BSRed)$Classification \%in\% 'SNP' &!
    is.na(fData(BSRed)$Chromosome)
inheritP <- resolveInheritanceSNP(BSRed[iSNP,])

#Match paralogs with map
chromHits <- locateParalogues(BSRed[iSNP,],paraCalls,inheritP)

#The example data and map are too small to detect most homeologies
plotCountsChrom(chromHits$cPerMarker,1:sum(iMSV5),at=1:15,
    labels=dimnames(chromHits$c)[[2]],las=2)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
