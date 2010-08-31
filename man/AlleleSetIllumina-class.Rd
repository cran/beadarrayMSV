\name{AlleleSetIllumina-class}
\Rdversion{1.1}
\docType{class}
\alias{AlleleSetIllumina-class}
\alias{initialize,AlleleSetIllumina-method}

\title{Class to Contain Objects Describing High-Throughput Illumina BeadArrays}
\description{Container for high-throughput assays and experimental
  metadata. \code{"AlleleSetIllumina"} class is derived from
  \code{"\link[Biobase:eSet]{eSet}"} and requires matrices
  \dQuote{intensity}, \dQuote{theta}, and \dQuote{SE} as assay data
  members}
\section{Objects from the Class}{
  \code{new("AlleleSetIllumina", \dots)}
  
  \code{new("AlleleSetIllumina", phenoData = [AnnotatedDataFrame],
    featureData = [AnnotatedDataFrame], experimentData = [MIAME],
    annotation = [character], intensity = [matrix], theta = [matrix],
    SE = [matrix], \dots)}
  
  Most arguments are optional, however usually the arguments to \code{new}
  include at least \dQuote{intensity}, \dQuote{theta}, and \dQuote{SE}. Note
  that several methods requires additional \code{assayData},
  \code{phenoData}, or \code{featureData} entries

  \code{"AlleleSetIllumina"} instances are usually created from
  \code{"\linkS4class{BeadSetIllumina}"} instances using
  \code{\link{createAlleleSet}} or from text-files using
  \code{\link{createAlleleSetFromFiles}}
}
\section{Slots}{
  Inherited from \code{"\link[Biobase:eSet]{eSet}"}:
  \describe{
    \item{\code{assayData}:}{Object of class \code{"AssayData"},
      with storage mode \dQuote{list}. Contains data-matrices with
      rows corresponding to markers and columns to samples/arrays. Required
      members are \dQuote{intensity}, \dQuote{theta}, and \dQuote{SE}. May also
      include intensities \dQuote{A} and \dQuote{B} (see
      \code{\link{createAlleleSet}}), \dQuote{call} (see
      \code{\link{callGenotypes}}), \dQuote{ped.check} (see
      \code{\link{validateCallsPedigree}}), or
      any other suitable matrix} 
    \item{\code{phenoData}:}{Object of class
      \code{"AnnotatedDataFrame"} with additional information about the
      samples}
    \item{\code{featureData}:}{Object of class
      \code{"AnnotatedDataFrame"} with additional information about the markers}
    \item{\code{experimentData}:}{Object of class \code{"MIAME"}}
    \item{\code{annotation}:}{Object of class \code{"character"}}
    \item{\code{.__classVersion__}:}{Object of class \code{"Versions"}}
  }
}
\section{Extends}{
  Class \code{"\linkS4class{eSet}"}, directly.
  Class \code{"\linkS4class{VersionedBiobase}"}, by class \code{"eSet"}, distance 2.
  Class \code{"\linkS4class{Versioned}"}, by class \code{"eSet"}, distance 3.
}
\section{Methods}{
  Class-specific methods:
  \describe{
    \item{\code{initialize}:}{\code{signature(.Object = "AlleleSetIllumina")}:
      Object instantiation, can be called by derived classes but not usually by the user}
    \item{\code{validObject(object)}:}{Validity-checking method,
      ensuring (1) all \code{assayData} components have the same number and names of
      features and samples; (2) the number and names of \code{phenoData}
      and \code{featureData} rows match the number and names of
      \code{assayData} columns and rows, respectively; (3)
      \code{storageMode(object)} is set to \dQuote{list}}
    \item{\code{assignToAlleleSet(object,object1)}:}{Used to assign
      data in \code{object1} to corresponding features in
      \code{object}, given the \code{phenoData} are identical between the two
    }
  }
  
  A selection of methods inherited from \code{"\link[Biobase:eSet]{eSet}"}:
  \describe{
    \item{\code{sampleNames(object)},
      \code{sampleNames(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{featureNames(object)},
      \code{featureNames(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{phenoData(object)},
      \code{phenoData(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{pData(object)}, \code{pData(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{varMetadata(object)}}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{varLabels(object)}}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{featureData(object)},
      \code{featureData(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{fData(object)}, \code{fData(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{fvarMetadata(object)}}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{fvarLabels(object)}}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{assayData(object), assayData(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{combine(object,object1)}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    \item{\code{storageMode(object)}:}{See
      \code{"\link[Biobase:eSet]{eSet}"}.  Do not assign new values to
      \code{storageMode}, as this could render the object invalid
    }
    %\item{\code{dims(object)}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{experimentData(object)}, \code{experimentData(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{description(object)},\code{description(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{notes(object)},\code{notes(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{pubMedIds(object)}, \code{pubMedIds(eSet,value)}}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{abstract(object)}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{annotation(object)},\code{annotation(object) <- value}}{See \code{"\link[Biobase:eSet]{eSet}"}}
    %\item{\code{preproc(object)},\code{preproc(object) <- value}:}{See \code{"\link[Biobase:eSet]{eSet}"}}
  }
}
\references{
  L. Gidskehaug, M. Kent, B. Hayes, and S. Lien. Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \bold{Submitted}
}
\author{
  Lars Gidskehaug
}
\seealso{
  \code{\link{createAlleleSet}},  \code{\link{callGenotypes}},
  \code{\link{preprocessBeadSet}}, \code{\linkS4class{BeadSetIllumina}},
  \code{\linkS4class{MultiSet}}}
\examples{
showClass("AlleleSetIllumina")
}
\keyword{classes}
