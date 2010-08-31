\name{readBeadSummaryOutput}
\Rdversion{1.1}
\alias{readBeadSummaryOutput}
\title{
  Read bead-summary intensities from two colour Illumina (Infinium) scanner
}
\description{
  Reads text-files with bead summary output for each array and arranges
  the data in a \code{"\linkS4class{BeadSetIllumina}"} object
}
\usage{
readBeadSummaryOutput(arrayNames = NULL, path = ".",
    pattern = "beadTypeFile.txt", recursive = FALSE, sep = ",",
    fullPaths = NULL, sepchar = "_")
}
\arguments{
  \item{arrayNames}{
    Character vector containing names of arrays to be read. If
    \code{fullPaths} is specified, \code{arrayNames} searches only among
    these, otherwise it searches in current working directory. More commonly
    \code{arrayNames} is \code{NULL}, then all arrays in current working
    directory or as specified in \code{fullPaths} are read
  }
  \item{path}{
    Character string specifying the data-directory
  }
  \item{pattern}{
    Character string specifying the file-name ending of the files to be read
}
  \item{recursive}{
    If \code{fullPaths} is not specified, the logical \code{recursive} regulates
    whether or not the function should look for files recursively
  }
  \item{sep}{
    Delimiter in text-files
  }
  \item{fullPaths}{
    Character vector containing the names of the files of interest,
    including the directories in which they are found (from the working
    directory \code{path}). Typically on a form similar to
    \code{<chip>/<chip>_<row>_<pattern>}. Useful when the current
    directory contains arrays from several experiments/families, and
    only a subset is to be loaded at the time. Usually used in
    combination with \code{arrayNames=NULL}
  }
  \item{sepchar}{
    Character used to bind togeher different parts of the file-names
    (\dQuote{_} in the above example)
  }
}
\details{
  The scanner protocol must be set to save bead-summary data. The
  function expects the following data-fields in each file:
  \dQuote{Illumicode}, \dQuote{N}, \dQuote{Mean GRN}, \dQuote{Dev GRN},
  \dQuote{Mean RED}, \dQuote{Dev RED} (in that order). The first two are
  the bead-type ID and the number of detected beads. The rest contain a
  robust bead-type mean and the standard deviation of the signal for
  each channel.

  Much of the functionality is adapted from the
  \pkg{beadarray} package (Dunning \emph{et al.}, 2007). This package is
  an excellent resource for loading and analysing raw Illumina BeadArray
  data, including images. 
}
\value{
  \code{"\linkS4class{BeadSetIllumina}"} object, with the
  \code{assayData} entries
  \item{R }{Mean red signal (\code{"Mean RED"})}
  \item{se.R }{Standard error of the mean red signal (\code{"Dev RED"/sqrt("N")})}
  \item{G }{Mean green signal (\code{"Mean GRN"})}
  \item{se.G }{Standard error of the mean green signal (\code{"Dev GRN"/sqrt("N")})} 
  \item{no.beads }{Number of detected beads}
}
\references{
  M. J. Dunning \emph{et al.} (2007) beadarray: R classes
  and methods for Illumina bead-based data. \emph{Bioinformatics}
  \bold{23}(16):2183-4

  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
\author{
Lars Gidskehaug
}
\seealso{
  \code{\linkS4class{BeadSetIllumina}}, \code{\link{scatterArrays}},
  \code{\link{preprocessBeadSet}}, \code{\link{createAlleleSet}}
}
\examples{
\dontrun{
#Read a BeadSetIllumina object using files in example data directory
rPath <- system.file("extdata", package="beadarrayMSV")
BSDataRaw <- readBeadSummaryOutput(path=rPath,recursive=TRUE)

#Print information from object
BSDataRaw
pData(BSDataRaw)
varMetadata(BSDataRaw)

#Alternatively:
sampleFile <- paste(rPath,'sampleData.txt',sep='/')
sampleInfo <- read.table(sampleFile,skip=8,sep='\t',header=TRUE,
    colClasses='character')
rownames(sampleInfo) <- make.names(paste(sampleInfo$chip,
    sampleInfo$row,sep='_'))
pattern <- 'beadTypeFile.txt'
fullPaths <- paste(sampleInfo$chip,'/',sampleInfo$chip,'_',
    sampleInfo$row,'_',pattern,sep='')
BSDataRaw <- readBeadSummaryOutput(fullPaths=fullPaths[1:4],
    path=rPath,pattern=pattern)

## Plot G vs. R
dev.new()
scatterArrays(BSDataRaw,smooth=FALSE)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
