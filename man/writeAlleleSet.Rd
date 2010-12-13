\name{writeAlleleSet}
\Rdversion{1.1}
\alias{writeAlleleSet}
\title{
  Write AlleleSetIllumina data to files
}
\description{
  Writes \code{assayData}, \code{phenoData}, and/or \code{featureData}
  of \code{"\linkS4class{AlleleSetIllumina}"} objects to text-files
}
\usage{
writeAlleleSet(dataFiles, BSRed, append = TRUE, sep = "\t",
    quote = FALSE)
}
\arguments{
  \item{dataFiles}{
    List with file-names (see \code{\link{makeFilenames}}). Only
    elements of \code{BSRed} indicated here are saved
  }
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object
  }
  \item{append}{
    If \code{TRUE}, append data rather than overwrite files (see \code{\link{write.table}})
  }
  \item{sep}{
    Field delimiter string (see \code{\link{write.table}})
  }
  \item{quote}{
    If \code{TRUE}, character and factor columns are quoted (see \code{\link{write.table}})
  }
}
\details{
  The data-tables specified is written to text-files for subsequent
  loading using
  \code{\link{createAlleleSetFromFiles}}
  (or similar). The pre-processed \emph{data}-files \dQuote{intFile},
  \dQuote{thFile}, \dQuote{seFile}, and \dQuote{phFile} are used to estimate the
  \emph{result}-files \dQuote{callFile}, \dQuote{resFile}, and
  \dQuote{genoFile}. Subsequent overwriting of data-files may therefore
  invalidate result-file. Therefore, no data-files will be
  saved if result-files are saved in the same run.
}
\value{
  This function is used for its side effects
}
\author{
  Lars Gidskehaug
}
\note{
  The \code{assayData}-entries \dQuote{intensity}, \dQuote{theta}, and
  \dQuote{SE} are written array-wise to file. This enables
  pre-processing of a subset of arrays at the time. The entries
  \dQuote{call} and \dQuote{genotype} are written marker-wise, which
  enables genotype-calling of a subset of markers at the time
}

\section{Warning }{
  Use with caution, as files will be overwritten without question if so specified
}

\seealso{
  \code{\link{createAlleleSetFromFiles}}, \code{\link{makeFilenames}},
  \code{\linkS4class{AlleleSetIllumina}} 
}
\examples{
\dontrun{
#Create an AlleleSetIllumina object using files in example data directory
rPath <- system.file("extdata", package="beadarrayMSV")
normOpts <- list(transf='root',method='medianAF')
dataFiles <- makeFilenames('testdata',normOpts,rPath)
beadFile <- paste(rPath,'beadData_testdata.txt',sep='/')
beadInfo <- read.table(beadFile,sep='\t',header=TRUE,as.is=TRUE)
BSRed <- createAlleleSetFromFiles(dataFiles[1:4],beadInfo=beadInfo)

#Write some data to files
writeFiles <- makeFilenames('test2',normOpts,path='.')
writeAlleleSet(writeFiles[1:4],BSRed[1:10,1:5])
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
