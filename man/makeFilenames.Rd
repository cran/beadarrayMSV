\name{makeFilenames}
\Rdversion{1.1}
\alias{makeFilenames}
\alias{modifyExistingFilenames}
\title{
  Generate filenames reflecting normalizations
}
\description{
  Filenames including paths are generated to enable writing a set of
  \code{"\linkS4class{AlleleSetIllumina}"} data-tables to text-files. These are
  used subsequently to read specified markers and arrays into the workspace
}
\usage{
makeFilenames(tag, normOpts, path = ".")

modifyExistingFilenames(dataFiles, oldtag, newtag)
}

\arguments{
  \item{tag}{
    Character string included in the filenames which is unique to the
    current analysis
  }
  \item{normOpts}{
    List with pre-processing options used (see
    \code{\link{setNormOptions}}). Generated filnames will reflect
    the transformation and channel-normalisation performed on the data
  }
  \item{path}{
    Character string with the saving path
  }
  \item{dataFiles}{
    Character vector with previous output from \code{makeFilenames}
  }
  \item{oldtag}{
    Often several rounds of genotype-calling is performed based on the
    same, pre-processed data. This character string correspond to the
    unique tag used for the previous run(s).
  }
  \item{newtag}{
    A new character string tag to replace \code{oldtag} in files other
    than those pre-processed data-files which remain the same between
    runs. 
  }
}
\details{
  These files generate file names used for reading and writing between
  text files and workspace. When different runs of genotype calling is
  performed using the same, pre-processed data,
  \code{modifyExistingFilenames} updates only the elements which change with
  the new genotyping.
}
\value{
  Character vector with the fields
  \item{intFile }{File name for \code{intensity} values}
  \item{thFile }{File name for \code{theta} values}
  \item{seFile }{File name for \code{SE} values}
  \item{phFile }{File name for phenotype data}
  \item{callFile }{File name for \code{call} values}
  \item{resFile }{File name for feature data such as call statistics}
  \item{genoFile }{File name for \code{allele} values}
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
\section{Warning }{
  Warnings are issued if existing filenames are used, as this may lead
  to overwriting of these files in subsequent steps (no files are
  overwritten by the functions themselves)
}
\seealso{
  \code{\link{writeAlleleSet}}, \code{\link{createAlleleSetFromFiles}},
  \code{\link{createMultiSetFromFiles}}, \code{\link{translateThetaFromFiles}} 
}
\examples{
#Create names
normOpts <- setNormOptions()
tag <- '1'
dataFiles <- makeFilenames(tag,normOpts)
print(dataFiles)

#Make new names for subsequent, alternate genotype calling runs
dataFiles <- modifyExistingFilenames(dataFiles,tag,'2')
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
