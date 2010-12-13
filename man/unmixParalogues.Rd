\name{unmixParalogues}
\Rdversion{1.1}
\alias{unmixParalogues}
\title{
  Partially resolve the paralogs of MSV-5s
}
\description{
  Based on parental and offspring MSV-5 marker genotypes, the paternal
  and maternal alleles in offspring are partally deduced. Those
  calls that can be split into two individual paralogs are returned. As
  the chromosome numbers of the individual paralogs are not known, the
  individual genotype calls are assigned assuming known location of the
  paralogs of each parent separately.
}
\usage{
unmixParalogues(BSRed, singleCalls = getSingleCalls(BSRed))
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
  \item{singleCalls}{
    Matrix holding the calls for all markers whose both paralogs are
    \dQuote{AA}, \dQuote{AB}, or \dQuote{BB} (see
    \code{\link{getSingleCalls}})
  }
}
\details{
  This is the first step towards resolving MSV-5 paralogs, in
  the sense that the \emph{mixed} signal from a 
  duplicated marker is split into two paralogue-specific signals. Within
  the half-sib family of one parent at the time, the individual paralogs
  are arbitrarily named. Then, for each informative meiosis, the
  offspring genotype call for each  paralogue is set to be either zero
  or one, depending on whether the allele inherited from the parent in
  question is \dQuote{A} or \dQuote{B}, respectively. This is repeated
  for all parents, yielding two sparse data-tables, one for the male and
  one for the female parent half-sib families. The alternate parents'
  calls are set to missing. The data-tables may separately be used for
  linkage mapping using other software, however better results are
  expected if the tables can be merged first. This involves positioning
  of the paralogs on their respective chromosomes and requires a linkage
  map (see \code{\link{assignParalogues}}).
}
\value{
  A list with elements
  \item{mother }{Matrix of calls representing maternal inherited alleles}
  \item{father }{Matrix of calls representing paternal inherited alleles}\cr
  The number of rows in both matrices is twice the number of markers, and
  the names of the paralogs are appended with \dQuote{_Para1} or
  \dQuote{_Para2}. Critically, these names are NOT consistent between the
  tables 
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
  \code{\link{assignParalogues}}, \code{\link{getSingleCalls}},
  \code{\link{translateTheta}}
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
iMSV5 <- fData(BSRed)$Classification \%in\% 'MSV-5' & fData(BSRed)$Ped.Errors \%in\% 0
plotGenotypes(BSRed,markers=which(iMSV5))

#Partial resolving of paralogs
paraCalls <- unmixParalogues(BSRed[iMSV5,])

#Compare for an arbitrary, single triplet
iOffspring <- 1
iFather <- which(pData(BSRed)$PedigreeID \%in\% pData(BSRed)$Parent2[iOffspring])
iMother <- which(pData(BSRed)$PedigreeID \%in\% pData(BSRed)$Parent1[iOffspring])
print(assayData(BSRed)$call[iMSV5,c(iMother,iFather,iOffspring)])
print(paraCalls$mother[,c(iMother,iFather,iOffspring)])
print(paraCalls$father[,c(iMother,iFather,iOffspring)])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
