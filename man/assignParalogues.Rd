\name{assignParalogues}
\Rdversion{1.1}
\alias{assignParalogues}
\alias{setMergeOptions}
\title{
  Assign MSV-5 paralogs to chromosomes
}
\description{
  Based on linkage information and a set of MSV-5 markers which have
  been split into individual paralogs within half-sib families, this
  function attempts to map the paralogs to their respective
  chromosomes and name them accordingly
}
\usage{
setMergeOptions(minC = NULL, noiseQuantile = 0.75,
    offspringLim = 7, ratioLim = 0.9, rngLD = 5)

assignParalogues(BSSnp, BSRed,
    paraCalls = unmixParalogues(BSRed, singleCalls),
    inheritP = resolveInheritanceSNP(BSSnp),
    singleCalls = getSingleCalls(BSRed),
    cHits = locateParalogues(BSSnp, paraCalls, inheritP,
        mO$offspringLim, mO$ratioLim)$cPerMarker,
    mO = setMergeOptions())
}
\arguments{
  \item{minC}{
    A numeric value corresponding to the elements of \code{cHits} below
    which no chromosomes are detected
  }
  \item{noiseQuantile}{
    The quantile of the third largest chromosomes across markers from
    which \code{minC} may be estimated
  }
  \item{offspringLim}{
    In order for a match between a paralogue and a chromosome to be
    detected, the number of (informative) half-siblings must
    equal or exceed this numeric value
  }
  \item{ratioLim}{
    The patterns of paternal and maternal inherited alleles among
    half-sib family offspring are compared between MSV-5 paralogs (see
    \code{\link{unmixParalogues}}) and genetic map SNPs (see
    \code{\link{resolveInheritanceSNP}}). The
    ratio of matching allele patterns between the two must equal or
    exceed this numeric value in order for a chromosome match to be
    detected 
  }
  \item{rngLD}{
    Numeric indicating how many map-units (e.g. cM) to include on each side
    of the genetic map marker to increase the number of informative
    meioses and the power of the associations with the paralogs.
  }
  \item{BSSnp}{
    \code{"\linkS4class{AlleleSetIllumina}"} (or
    \code{"\linkS4class{MultiSet}"}) object containing SNPs of
    known location on the chromosomes, including an \code{assayData}
    entry \dQuote{call}. A \code{phenoData} column
    \code{PedigreeID} must be included on the form
    <p><mmm><fff><oo>, identifying the population, mother,
    father and individual offspring, respectively. The
    \code{featureData} variables \dQuote{Chromosome}, \dQuote{Female},
    and \dQuote{Male} give the numbered chromosome and the genetic
    distances on the female and male map, respectively
  }
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} (or
    \code{"\linkS4class{MultiSet}"}) object containing
    MSV-5's to be mapped, with a required \code{assayData}-list entry
    \dQuote{call}. Must contain the same samples as \code{BSSnp}, and
    also a \code{phenoData} column \dQuote{PedigreeID}
  }
  \item{paraCalls}{
    List containing two matrices, \dQuote{mother} and \dQuote{father}, with the
    parental inherited alleles of individual paralogs assuming unknown
    alternate parent (see \code{\link{unmixParalogues}})
  }
  \item{inheritP}{
    List containing two matrices, \dQuote{mother} and \dQuote{father}, with the
    parental inherited alleles for the markers in \code{BSSnp} (see
    \code{\link{resolveInheritanceSNP}}) 
  }
  \item{singleCalls}{
    Matrix containing MSV-5s for which both paralogs are either
    monomorphic or polymorphic (see \code{\link{getSingleCalls}})
  }
  \item{cHits}{
    A three-dimensional array of size (markers x chromosomes x 2)
    containing an average number of matches of a paralogue to a
    chromsome for both the mothers and fathers (average across the
    number of markers in the map for that chromosome; see
    \code{\link{locateParalogues}})
  }
  \item{mO}{
    List with options used in the mapping of paralogs (see
    \code{\link{setMergeOptions}}) 
  }
}
\details{
  While the function \code{\link{locateParalogues}} allows for matching
  of paralogs to any chromosome, \code{assignParalogues} uses the former
  output and limits the allowed choices to one or two chromosomes. The
  paralogs are given names reflecting these chromosomes, which allows
  for merging of the linkage information in \code{paraCalls} into a
  single, much more informative data-table.

  Initially, the largest value of \code{cHits} between \dQuote{mother} and
  \dQuote{father} is chosen, and the resulting scores are sorted decreasingly
  among chromosomes one marker at the time. Up to
  two of the highest scoring chromosomes are selected if their values
  exceed \code{mO$minC}. If this element is \code{NULL}, it will be
  estimated based on the \code{mO$noiseQuantile}'th quantile of the
  third highest ranking chromosomes across markers. Also, the second
  ranking chromosome will not be selected unless it scores twice as
  high as the third ranking chromosome. Using the maternal and paternal
  half-sib families in turn, each paralogue is mapped to either of the
  selected chromosomes if sufficient association is detected.
  
  For each half-sib family and each (informative) paralogue, only
  genetic map markers for which the parent in question is heterozygous
  are useful. This reduces the number of genetic map markers to which
  the paralogs can be associated. Similarly, for only a subset of the
  half-siblings are the parental inherited alleles in each paralogue
  known. This tends to reduce the number of informative offspring in
  each family drastically. Missing parental alleles among the genetic
  map markers further reduce the numbers of informative offspring,
  however these may sometimes be imputed using neighbouring markers
  assumed to be in linkage disequilibrium (LD) with the marker in
  question. The option \code{rngLD} indirectly controls the number of
  helping markers to use. 

  The mapping itself proceeds by applying the filter defined in
  \code{mO} to the genetic map markers on a specific chromosome (see
  \code{\link{locateParalogues}} for specifics about the filter). A set of
  statistics are then calculated to find the marker that matches the
  chromosome most closely. If there are two candidate chromosomes, the
  one with the highest ranked marker is selected. If there is only one
  candidate, it is selected if it outranks all the other chromosomes in
  terms of the calculated statistics. If a succesfull match is found,
  the parental inherited alleles for that family are assigned to the
  paralogue whose name reflects the chromosome match.
}
\value{
  A list containing
  \item{x}{a matrix holding the calls for those paralogs that are
    successfully mapped to a chromosome. The rownames reflect the
    chromosome as well as the marker-name}
  \item{chromPairs}{a matrix with 0, 1, or 2 chromosomes to which the
    MSV-5's have been succesfully mapped}
  \item{positionFemale}{a matrix holding the mapped paralogue positions
    as estimated by the female parent half-sib families}
  \item{positionMale}{a matrix holding the mapped paralogue positions
    as estimated by the male parent half-sib families}
}
\author{
  Lars Gidskehaug
}
\note{
  This function may be time consuming, and even more so if many of the
  input parameters need be re-calculated each time. If some of them are
  available in the workspace, save time by including them in the function call
}
\seealso{
  \code{\link{plotCountsChrom}}, \code{\link{setMergeOptions}},
  \code{\link{unmixParalogues}}, \code{\link{resolveInheritanceSNP}},
  \code{\linkS4class{MultiSet}},
  \code{\linkS4class{AlleleSetIllumina}},
  \code{\link{locateParalogues}},
  \code{\link{getSingleCalls}}
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
singleCalls <- getSingleCalls(BSRed[iMSV5,])
paraCalls <- unmixParalogues(BSRed[iMSV5,],singleCalls)

#Genetic map SNPs and inherited parental alleles
iSNP <- fData(BSRed)$Classification \%in\% 'SNP' &!
    is.na(fData(BSRed)$Chromosome)
inheritP <- resolveInheritanceSNP(BSRed[iSNP,])

#Match paralogs with map
mO <- setMergeOptions(minC=1)
chromHits <- locateParalogues(BSRed[iSNP,],paraCalls,
   inheritP,mO$offspringLim,mO$ratioLim)

#The example data and map are too small to detect most homeologies
plotCountsChrom(chromHits$cPerMarker,1:sum(iMSV5),at=1:15,
   labels=dimnames(chromHits$c)[[2]],las=2)

#Only a few, single paralogs are succesfully assigned to chromosomes
mergedCalls <- assignParalogues(BSRed[iSNP,],BSRed[iMSV5],paraCalls,
   inheritP,singleCalls,cHits=chromHits$cPerMarker,mO=mO)
print(mergedCalls$chromPairs)
print(mergedCalls$x[,1:4])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
