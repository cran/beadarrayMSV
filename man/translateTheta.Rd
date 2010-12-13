\name{translateTheta}
\Rdversion{1.1}
\alias{translateTheta}
\alias{translateThetaCombined}
\alias{translateThetaFromFiles}
\title{
  Convert genotype calls to allele information
}
\description{
  Genotype calls represented as numeric values (allele ratios) within
  [0, 1] are converted to character strings containing allele
  information \dQuote{A}, \dQuote{T}, \dQuote{C}, and \dQuote{G}
}
\usage{
translateTheta(calls, resInfo, type = "regular")

translateThetaCombined(BSRed, mergedCalls = NULL)

translateThetaFromFiles(dataFiles, mergedCalls = NULL,
    markerStep = 1000, sep = "\t", quote = "")
}
\arguments{
  \item{calls}{
    Numeric matrix with calls \{0, 1/2, 1\} representing allele ratios for each
    sample. Each row is a unique marker or paralogue (specified with \code{type})
  }
  \item{resInfo}{
    Data table containing \code{featureData}, including the columns
    \dQuote{Classification}, \dQuote{SNP}, and
    \dQuote{ILMN.Strand}. These hold the genotype categories from
    \code{\link{callGenotypes}} and the SNP and
    TOP/BOT-category of the BeadArray markers (see
    \code{\link{createAlleleSet}})
  }
  \item{type}{
    One of \dQuote{regular}, \dQuote{single}, or \dQuote{merged} (see
    details below)
  }
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object containing an
    \code{assayData} entry \dQuote{call} and a \code{featureData} column
    \dQuote{Classification} (see \code{\link{callGenotypes}})
  }
  \item{mergedCalls}{
    Matrix with calls from resolved MSV-5 paralogs (see
    \code{\link{assignParalogues}})
  }
  \item{dataFiles}{
    Character vector containing file names (see \code{\link{makeFilenames}})
  }
  \item{markerStep}{
    The maximum number of markers loaded into the workspace at the time
  }
  \item{sep}{
    Field delimiter in text-files (see \code{\link{read.table}})
  }
  \item{quote}{
    Quote-marks used for character strings (see \code{\link{read.table}})
  }
}
\details{
  The main difference between \code{translateTheta} and
  \code{translateThetaCombined} is that the former can only handle
  call-values \{0, 1/2, 2\} whereas the latter handles values
  \{0, 1/4, 1/2, 3/4, 1\}. In effect this means that markers from
  duplicated genome regions have to be handled in a special way if
  analysed with \code{translateTheta}. If \code{type == "regular"}, the
  markers are treated as if they were all from 
  a diploid region. This implies that all non-segregating paralogs of
  \dQuote{MSV-a} and \dQuote{MSV-b} markers are ignored, effectively
  turning these markers into SNPs. Markers classified as
  \dQuote{MSV-5} or \dQuote{PSV} are set to missing (see
  \code{\link{makeDiploidCalls}}). If \code{type == "single"},
  \code{calls} is expected to contain resolved \dQuote{MSV-5} paralogs named
  with \dQuote{-Para1} or \dQuote{-Para2} (see
  \code{\link{unmixParalogues}}). If \code{type == "merged"},
  resolved \dQuote{MSV-5} paralogs named according to their respective
  chromosomes, \dQuote{-ChromX}, are expected (see
  \code{\link{assignParalogues}}). The main use of this function is to
  prepare genotype calls for mapping software which requires diploid
  markers. 

  With \code{translateThetaCombined}, there is always one element per
  marker, as required by the \code{"\linkS4class{AlleleSetIllumina}"}. If
  \code{mergedCalls} is given, the \dQuote{MSV-5} paralogs will be
  resolved, otherwise only the ratio of the alleles across paralogs will
  be returned. The function \code{translateThetaFromFiles} performs the
  same operations on data sequentially loaded into the workspace, and
  the genotypes are written to file \code{dataFiles$genoFile} as they
  are found.
}
\value{
  Output from \code{translateTheta} is a matrix whose dimensions depend
  on the input data. If \code{calls} has one row per marker (i.e. \code{type
  == "regular"}), the number of rows in the output matrix also
  equals the number of markers. If \code{calls} has one row per
  paralogue (i.e. \code{type != "regular"}), the number of rows
  in the output matrix also equals the number of paralogs. Each element
  is a character string \dQuote{x y} denoting the two alleles
  (\dQuote{A}, \dQuote{T}, \dQuote{C}, \dQuote{G}, or \dQuote{-} for
  missing).

  In contrast, the output from \code{translateThetaCombined} is an
  \code{\linkS4class{AlleleSetIllumina}} object with an added \code{assayData}
  entry \dQuote{genotype}. The elements of this matrix representing
  diploid markers are given as \dQuote{xy}, un-resolved tetraploid markers
  are given as \dQuote{xyzw}, and resolved tetraploid markers are given
  as \dQuote{xy,zw} (paralogs separated by comma). The letters
  correspond to any of the 4 bases or \dQuote{-} for missing.

  The function \code{translateThetaFromFiles} are used for its side
  effects.
}
\author{
  Lars Gidskehaug
}
\seealso{
  \code{\link{makeDiploidCalls}}, \code{\link{unmixParalogues}},
  \code{\link{assignParalogues}}, \code{\link{makeFilenames}},
  \code{\link{callGenotypes}}
}
\examples{
\dontrun{
#Read 25 markers into an AlleleSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
normOpts <- setNormOptions()
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],markers=1:25,beadInfo=beadInfo)

#Genotype calling
BSRed <- callGenotypes(BSRed)
genotypes <- translateTheta(assayData(BSRed)$call,fData(BSRed),type='regular')
print(cbind(fData(BSRed)$Classification,genotypes[,1:3])[1:10,])

#Alternative output
BSRed <- translateThetaCombined(BSRed)
print(cbind(fData(BSRed)$Classification,assayData(BSRed)$genotype[,1:3])[1:10,])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
