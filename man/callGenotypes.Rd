\name{callGenotypes}
\Rdversion{1.1}
\alias{callGenotypes}
\alias{callGenotypes.interactive}
\alias{callGenotypes.verboseTest}
\alias{setGenoOptions}

\title{
  Clustering and calling of genotypes
}
\description{
  Clusters each marker into the most likely combination from a sequence
  of allowed cluster combinations. These may include multisite variants
  from polyploid genomes
}
\usage{
setGenoOptions(largeSample = FALSE, snpPerArrayLim = 0.8,
    arrayPerSnpLim = 0.8, ploidy = "tetra",
    filterLim = 0, detectLim = 0.8,
    wSpreadLim = suggestGeno(largeSample)$wSpreadLim,
    devCentLim = 0.35,
    hwAlpha = suggestGeno(largeSample)$hwAlpha,
    probsIndSE = suggestGeno(largeSample)$probsIndSE,
    afList = seq(0, 0.5, 0.05),
    clAlpha = suggestGeno(largeSample)$clAlpha,
    rPenalty = 2,
    rotationLim = suggestGeno(largeSample)$rotationLim,
    minClLim = 5, nSdOverlap = 2,
    minBin = suggestGeno(largeSample)$minBin,
    binWidth = suggestGeno(largeSample)$binWidth) 

callGenotypes(BSRed,
    gO = setGenoOptions(largeSample = ncol(BSRed) > 250))

callGenotypes.interactive(BSRed,
    gO = setGenoOptions(largeSample = ncol(BSRed) > 250))

callGenotypes.verboseTest(BSRed, singleMarker = 1,
    gO = setGenoOptions(largeSample = ncol(BSRed) > 250))
}

\arguments{
  \item{largeSample}{
    Logical indicating whether or not a large sample is genotyped, which
    influences the values of some default genotyping options. More than
    2-300 arays may be considered large
  }
  \item{snpPerArrayLim}{
    Minimum ratio of non-NA markers per array. Failing arrays are disregarded
  }
  \item{arrayPerSnpLim}{
    Minimum ratio of non-NA arrays per marker. Failing markers are disregarded
  }
  \item{ploidy}{
    Character string indicating which genotyping classes to allow (see
    \code{\link{generatePolyCenters}})
  }
  \item{filterLim}{
    Markers with range of \code{assayData} \dQuote{theta} below this
    value are classified as \dQuote{MONO-filt} and are not subjected to
    clustering. This option will speed up the analysis, however the calls
    and the statistics of classification will be missing for these markers
  }
  \item{detectLim}{
    Ratio of called samples below which markers are classified as \dQuote{FAIL}
  }
  \item{wSpreadLim}{
    The maximum allowed within cluster standard deviation along
    \code{assayData} \dQuote{theta}
  }
  \item{devCentLim}{
    The maximum allowed difference in \dQuote{theta} between expected and
    estimated cluster centres
  }
  \item{hwAlpha}{
     Significance level used in Hardy-Weinberg testing. Used to detect
     where the clustering fails, and a low value (e.g. 1e-10 - 1e-40) may be
     used to allow natural deviation from HW. This criterion should be
     used with caution, especially when the sample contains animals from
     different populations
  }
  \item{probsIndSE}{
    Numeric quantile for which markers with higher standard errors are
    excluded from the clustering step (however not discarded)
  }
  \item{afList}{
    Numeric vector of values within [0, 0.5], denoting which B allele
    frequencies to test in the case of two segregating paralogs (see below)
  }
  \item{clAlpha}{
    Numeric significance level for Hotelling's \eqn{T^2} test (see below)
  }
  \item{rPenalty}{
    Scaling for the ordinate axis spanned by \code{assayData}
    \dQuote{intensity} (see below). A high value means the influence of
    the intensity in the clustering is decreased
  }
  \item{rotationLim}{
    Controls the maximum allowed tilt of clusters, as defined by
    Hotelling's ellipses (see below)
  }
  \item{minClLim}{
    Clusters below this minimum size are disregarded in the
    Hotelling's test (all animals included in cluster)
  }
  \item{nSdOverlap}{
    Numeric multiple of \code{assayData} \dQuote{theta} standard deviations defining within
    cluster spread
  }
  \item{minBin}{
    When estimating initial center points for the clustering, histogram
    peaks below this numeric value are set to zero
  }
  \item{binWidth}{
    Starting value for histogram bin-width used to find initial
    center points. Smaller clusters are detected with smaller bin-width
   }
  \item{BSRed}{
    \code{"\linkS4class{AlleleSetIllumina}"} object, holding a required
    \code{phenoData} column \dQuote{noiseIntensity} (see
    \code{\link{preprocessBeadSet}}) 
  }
  \item{gO}{
    List of options and cut-off limits used in the clustering (see
    \code{setGenoOptions})
  }
  \item{singleMarker}{
    Index to a specific marker to test
  }
}
\details{
  Initially, arrays with a fraction of non-NA markers less
  than \code{gO$snpPerArrayLim}, and markers with a fraction of non-NA
  arrays less than \code{gO$arrayPerSnpLim}, are discarded from the
  analysis. Also, markers with range of \code{assayData} \dQuote{theta}
  below \code{gO$filterLim} are called \dQuote{MONO-filt} and are not
  subjected to clustering.
  
  Genotype calling for each marker is based on \link[=kmeans]{k-means}
  clustering in the two dimensions defined by \code{assayData} entries
  \dQuote{intensity} and \dQuote{theta}, where \dQuote{intensity} is
  penalized by \code{gO$rPenalty} times its median value. The value of
  \code{gO$ploidy} sets the allowed  cluster combinations through the function
  \code{\link{generatePolyCenters}}. Data points below the average value
  of the \code{phenoData} column \dQuote{noiseIntensity} across included
  arrays are set to missing, and samples with standard errors exceeding
  the quantile given by \code{gO$probsIndSE} are left out from the clustering
  step. Two or three of the most likely cluster combinations are
  estimated with the function \code{\link{getCenters}}. This function
  uses histograms to find starting values for the clustering, with input
  parameters \code{gO$minBin} defining a peak-height filter and
  \code{gO$binWidth} setting an initial bin-width. The ranked
  cluster combinations are tested in turn until one is found which
  passes the criteria below.

  First, \code{gO$devCentLim} controls the maximum distance a cluster is allowed
  to deviate from its expected or ideal position. Second, \code{gO$wSpreadLim}
  limits how large the within cluster standard deviation can be. Both
  these criteria are tested in the \dQuote{theta}-dimension, and if either fails,
  the algorithm will attempt to cluster the next most likely
  configuration and start over.

  The next test is for Hardy-Weinberg (HW)
  equilibrium. This is a very powerful test to detect if the clustering
  has failed, given HW can be assumed. Otherwise, set the significance value
  \code{gO$hwAlpha} to zero to allow any deviation from HW. At
  duplicated loci, the observed B allele-frequency (BAF) is in 
  fact the mean BAF across both paralogues. Several candidate values
  of BAF for one paralogue are set in \code{gO$afList}, such that
  the BAF for the other paralogue is given. Several values of
  \code{gO$afList} within [0, 0.5] are tested for HW, and the most
  likely BAF at both paralogs are those resulting in the highest p-value.
  Another, somewhat less powerful, quality control test is to look for
  overlapping clusters. If a cluster centre on the \dQuote{theta}-axis is
  denoted \code{Cent}, and its spread is given by \code{Within.SD},
  clusters are tested for overlap using \code{Cent +/- gO$nSdOverlap * Within.SD}

  Markers passing the quality control
  are subjected to a Hotelling's \eqn{T^2}-test (Hotelling, 1931; Gidskehaug et
  al., 2007), which effectively superimposes an ellipse on each cluster
  and discards all data points falling outside its boundaries or within 
  overlapping ellipses. Due to inaccurate ellipses for small clusters,
  only clusters with more than \code{gO$minClLim} members are
  tested. The extents of the clusters are controlled by the significance
  level \code{gO$clAlpha} of the \eqn{T^2}-tests in such a way that a
  small value yield large ellipses. The orientation of an ellipse is
  defined by the ratio of variances in the variance-/covariance matrix
  from the Hotelling's test. If the ratio of the \dQuote{theta}-variance
  to the \dQuote{intensity}-variance is given by \code{Sratio}, the
  weighted sum of \code{Sratio} across clusters is not allowed to exceed
  \code{gO$rotationLim}. Finally, the call rate is required to exceed \code{gO$detectLim}, or
  the algorithm will move on to the next most likely cluster combination. If a
  marker passes all the tests for one of the candidate cluster
  combinations, the genotype is called. Otherwise the marker is failed
  (i.e. called \dQuote{FAIL}).

  \code{callGenotypes} is the main genotype calling function. Before
  genotyping thousands of markers, it is important spend a little time
  tuning the options in \code{gO}. A few hundred markers may be called
  using the default settings, and plotted using
  \code{\link{plotGenotypes}}. Individual markers whith questionable
  calls can be investigated more closely using
  \code{callGenotypes.verboseTest}. This function performs all the tests
  described above, for all suggested cluster combinations, without
  failing any of the tests. Rather, all the test results are plotted and
  returned, revealing which steps can be taken to improve the
  clustering, if any. In these plots, green dots are the estimated
  centre points, and red and orange dots represent samples outside
  cluster boundaries or within overlapping ellipses,
  respectively. Several markers representing each of the possible
  genotype categories should be investigated in this way before commencing
  with genotyping the full set of markers. 

  For some markers with highly overlapping or inaccurate clusters,
  interactive clustering might be the last option. This can be performed
  using the function \code{callGenotypes.interactive} (requires package
  \pkg{rggobi} to be installed). This function
  will loop through a smaller set of markers, allowing the user to
  define clusters manually. Pedigree checking is performed inside the
  function, and a \code{phenoData} column \dQuote{PedigreeID} is
  required (see \code{\link{validateCallsPedigree}}).  Use the function
  \code{\link{assignToAlleleSet}} to incorporate the manual results into
  a larger \code{"\linkS4class{AlleleSetIllumina}"} object.
}
\value{
  Output from \code{setGenoOptions} is a list with all defined or
  suggested options needed for genotype calling
  
  Output from \code{callGenotypes} is an
  \code{"\linkS4class{AlleleSetIllumina}"} object with an extra
  \code{assayData} entry:
  \item{call }{Matrix with numeric values \{0, 1/4, 1/2, 3/4, 1\}, each
    indicating the ratio of B alleles for a marker in a sample}\cr 
  The \code{"\linkS4class{AlleleSetIllumina}"} output from
  \code{callGenotypes.interactive} in addition holds the 
  \code{assayData} entries:
  \item{ped.check }{Logical matrix with \code{FALSE} indicating
    pedigree violations among offspring. Parental values are all
    \code{NA} (see \code{\link{validateCallsPedigree}})}
  \item{ped.check.parents }{Matrix of numeric values \{0, 1, 2\}, denoting
    no error, offspring error, and parent error, respectively (see
    \code{\link{validateSingleCall}})}\cr
  The following columns are added to \code{featureData}: 
  \item{Classification }{Genotype call from automatic clustering}
  \item{Cent.Deviation }{Largest distance from cluster-centre to its ideal position}
  \item{Within.SD }{Largest within-cluster spread}
  \item{HW.Chi2 }{Chi-squared statistic from test of Hardy-Weinberg equilibrium}
  \item{HW.P }{Probability of Hardy-Weinberg equilibrium}
  \item{BAF.Locus1 }{Estimated B-allele frequency}
  \item{BAF.Locus2 }{Estimated BAF of second paralogue (if exists)}
  \item{Call.Rate }{Ratio of samples assigned to clusters}
  \item{Manual.Calls.R }{Calls from interactive clustering (if applied)}\cr
  Output from \code{callGenotypes.verboseTest} is a list containing
  \item{call }{The calls from each attempted cluster-combination}
  \item{fData }{Statistics from each cluster-combination}
  \item{fMetadata }{Explanation to each statistic}
  \item{test }{Table of \dQuote{PASS} or \dQuote{FAIL} for each test}
}
\references{
  L. Gidskehaug, E. Anderssen, A. Flatberg, and B. K. Alsberg (2007) A
  framework for significance analysis of gene expression data using
  dimension reduction methods. \emph{BMC Bioinformatics} \bold{8}:346\cr
  
  H. Hotelling (1931) The Generalization of Student's
  Ratio. \emph{Ann. Math. Stat.} \bold{2}(3):360-378
}
\author{
  Lars Gidskehaug
}
\note{
  When pedigree data are available, pedigree checking is a very strong
  type of validation which is performed \emph{after} the genotype
  calling in \code{callGenotypes}

  In \code{callGenotypes.interactive}, pedigree checking is performed
  \emph{during} genotype calling. This means the pedigree cannot
  subsequently be used as validation to the same degree as if it had
  been kept secret during genotype calling
}

\seealso{
  \code{\link{generatePolyCenters}}, \code{\link{getCenters}},
  \code{\link{findPolyploidClusters}}, \code{\link{testHardyWeinberg}},
  \code{\link[rggobi:ggobi]{ggobi}}, \code{\link{plotGenotypes}},
  \code{\link{validateCallsPedigree}}, \code{\link{assignToAlleleSet}},
  \code{\link{manualCall}}
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

#Genotype calling and validation
gO <- setGenoOptions(largeSample=TRUE)
BSRed <- callGenotypes(BSRed, gO=gO)
BSRed <- validateCallsPedigree(BSRed)
sumClass <- tapply(rep(1,nrow(BSRed)),fData(BSRed)$Classification,sum)
print(sumClass)

#Plot default setting calls
plotGenotypes(BSRed)

#Tune settings to call an initially failed marker
dev.new()
verboseRes <- callGenotypes.verboseTest(BSRed, gO=gO, singleMarker=23)
print(verboseRes$fData)
print(verboseRes$test)
gO <- setGenoOptions(largeSample=TRUE, wSpreadLim=.1, hwAlpha=1e-50)
verboseRes <- callGenotypes.verboseTest(BSRed, gO=gO, singleMarker=23)

#New settings give (likely incorrect) SNP-call
BSRed <- callGenotypes(BSRed, gO=gO)
BSRed <- validateCallsPedigree(BSRed)
dev.new()
plotGenotypes(BSRed)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
