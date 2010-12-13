\name{resolveInheritanceSNP}
\Rdversion{1.1}
\alias{resolveInheritanceSNP}
\title{
  Track parental alleles in offspring
}
\description{
  Based on parental and offspring SNP marker genotypes, the paternal and
  maternal alleles in offspring are deduced
}
\usage{
resolveInheritanceSNP(BSSnp)
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
    \dQuote{999} means unknown parent
  }
}
\details{
  Although a linkage map is not needed for this function, it was written
  for the purpose of mapping MSV-5 paralogs to a map represented by the
  markers in \code{BSSnp} (see \code{\link{assignParalogues}}). For its
  intended use, \code{BSSnp} should therefore contain chromosome
  positions and genetic distances in \code{featureData}
}
\value{
  A list with elements
  \item{mother }{Matrix of calls representing maternal inherited alleles}
  \item{father }{Matrix of calls representing paternal inherited alleles}
}
\author{
  Lars Gidskehaug
}
\note{
  Offspring alleles from monomorpic parents are sometimes missing even
  though the inherited alleles can be directly deduced from the parental
  genotype. This is for efficiency of the algorithm, as monomorphic
  parents carry no linkage information 
}

\seealso{
  \code{\linkS4class{AlleleSetIllumina}}, \code{\link{callGenotypes}},
  \code{\link{assignParalogues}}, \code{\link{unmixParalogues}}
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

#Genotype calling and selection of SNPs for linkage map
BSRed <- callGenotypes(BSRed)
BSRed <- validateCallsPedigree(BSRed)
iSNP <- fData(BSRed)$Classification \%in\% 'SNP' &! is.na(fData(BSRed)$Chromosome)

#Find informative alleles inherited from each parent
inheritP <- resolveInheritanceSNP(BSRed[iSNP,])

#Compare a few markers for an arbitrary, single triplet
iOffspring <- 1
iFather <- which(pData(BSRed)$PedigreeID \%in\% pData(BSRed)$Parent2[iOffspring])
iMother <- which(pData(BSRed)$PedigreeID \%in\% pData(BSRed)$Parent1[iOffspring])
print(assayData(BSRed)$call[iSNP,c(iMother,iFather,iOffspring)][6:10,])
print(inheritP$mother[6:10,c(iMother,iFather,iOffspring)])
print(inheritP$father[6:10,c(iMother,iFather,iOffspring)])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
