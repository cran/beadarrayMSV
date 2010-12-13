\name{createAlleleSet}
\Rdversion{1.1}
\alias{createAlleleSet}
\alias{createAlleleSetFromFiles}
\alias{createMultiSetFromFiles}
\alias{assignToAlleleSet}

\title{
  Create AlleleSetIllumina or MultiSet objects
}
\description{
  An \code{"\linkS4class{AlleleSetIllumina}"} (or
  \code{"\linkS4class{MultiSet}"}) object is created, either by 
  transforming a \code{"\linkS4class{BeadSetIllumina}"} object into an
  \code{"\linkS4class{AlleleSetIllumina}"} object, by reading from
  text-files containing pre-processed data, or by merging existing
  objects
}
\usage{
createAlleleSet(BSData, beadInfo, normOpts, includeAB = FALSE)

createAlleleSetFromFiles(dataFiles, markers, arrays,
    phenoInfo = NULL, beadInfo = NULL, sep = "\t", quote = "")

createMultiSetFromFiles(dataFiles, markers, arrays,
    phenoInfo = NULL, beadInfo = NULL, sep = "\t", quote = "")

assignToAlleleSet(BSRed, BSAdd)
}
\arguments{
  \item{BSData}{
    \code{"\linkS4class{BeadSetIllumina}"} object
  }
  \item{beadInfo}{
    Data-frame containing an entry for each marker, and the columns
    \dQuote{Name}, \dQuote{SNP}, \dQuote{ILMN.Strand},
    \dQuote{Address}, \dQuote{Address2}, and \dQuote{Norm.ID}, as
    exported from Illumina's GenomeStudio Genotyping Module (or
    relatives). May also contain columns relating to genotype calls (see
    \code{\link{callGenotypes}}) 
  }
  \item{normOpts}{
    List containing at least the elements \dQuote{dist} and
    \dQuote{pNorm} (see \code{\link{setNormOptions}})
  }
  \item{includeAB}{
    If \code{TRUE}, the Cartesian signal arrays \dQuote{A} and \dQuote{B} are
    returned as \code{assayData} entries in the new
    \code{"\linkS4class{AlleleSetIllumina}"} object 
  }
  \item{dataFiles}{
    Character vector containing filenames where the different
    data-tables are saved (see \code{\link{makeFilenames}})
  }
  \item{markers}{
    Index to markers in the \code{dataFiles} files
  }
  \item{arrays}{
    Index to arrays/samples in the \code{dataFiles} files
  }
  \item{phenoInfo}{
    Data-table with phenotype data. Argument is ignored if \dQuote{phFile} is provided in
    \code{dataFiles}
  }
  \item{sep}{
    Field delimiter in text-files (see \code{\link{read.table}})
  }
  \item{quote}{
    Quote-marks used for character strings (see \code{\link{read.table}})
  }
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object
  }
  \item{BSAdd}{
    \code{"\linkS4class{AlleleSetIllumina}"} object with data to
    include in \code{BSRed}
  }
}
\details{
  A \code{"\linkS4class{BeadSetIllumina}"} object contains bead-type information,
  whereas an \code{"\linkS4class{AlleleSetIllumina}"} object contains marker
  information (for each Infinum I marker, there are two
  bead-types). The function \code{createAlleleSet} takes a
  \code{"\linkS4class{BeadSetIllumina}"} object as input and merges the
  \dQuote{R} and \dQuote{G} intensities into \dQuote{A} and \dQuote{B}
  intensities. The former relates to bead-types and the latter relates
  to markers as defined in \code{beadInfo}. The required polar
  coordinate intensities \dQuote{intensity} and \dQuote{theta} are
  estimated based on \dQuote{A} and \dQuote{B}, and depend on the
  distance measures defined in \code{normOpts}. The angles \dQuote{theta}
  are scaled such that \{0, 90\} degrees are represented by \{0, 1\},
  and \dQuote{intensity} vs. \dQuote{theta} for single markers are
  usually plotted on Cartesian axes for genotype calling.

  If data-files are available for all required \code{assayData},
  \code{phenoData}, and \code{featureData} elements, an
  \code{"\linkS4class{AlleleSetIllumina}"} or a
  \code{"\linkS4class{MultiSet}"} object may be constructed
  with \code{create-AlleleSetFromFiles} or
  \code{createMultiSetFromFiles}, respectively. The former has three
  required \code{assayData} elements whereas the latter has none.
  
  Sometimes, and in particular after manual genotype calling, there is a
  need to update an \code{"\linkS4class{AlleleSetIllumina}"} object with new
  information. The function \code{assignToAlleleSet} adds any
  data in \code{BSAdd} to \code{BSRed}, overwriting previous data if
  there is a conflict
}
\value{
  Object of class \code{"\linkS4class{AlleleSetIllumina}"} or \code{"\linkS4class{MultiSet}"}
}
\author{
  Lars Gidskehaug
}
\seealso{
\code{\linkS4class{AlleleSetIllumina}},
\code{\linkS4class{MultiSet}}, \code{\link{writeAlleleSet}},
\code{\link{makeFilenames}}
}
\examples{
\dontrun{
#Read raw data files into BeadSetIllumina object
rPath <- system.file("extdata", package="beadarrayMSV")
BSDataRaw <- readBeadSummaryOutput(path=rPath,recursive=TRUE)

#Find indexes to sub-bead pools
beadInfo <- read.table(paste(rPath,'beadData.txt',sep='/'),sep='\t',
    header=TRUE,as.is=TRUE)
rownames(beadInfo) <- make.names(beadInfo$Name)
normInd <- getNormInd(beadInfo,featureNames(BSDataRaw))

#Pre-process BSData
normOpts <- setNormOptions(minSize=10)
plotPreprocessing(BSDataRaw,normInd,normOpts,plotArray=1)
BSData <- preprocessBeadSet(BSDataRaw,normInd,normOpts)
print(BSData)
print(fData(BSData)[1:10,])
print(fvarMetadata(BSData))

#Convert to AlleleSetIllumina-object
BSRed <- createAlleleSet(BSData,beadInfo,normOpts)
print(BSRed)
print(fData(BSRed)[1:10,])
print(fvarMetadata(BSRed))

#Read pre-processed data directly into AlleleSetIllumina object
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo2 <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],beadInfo=beadInfo2)
print(varLabels(BSRed))
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
