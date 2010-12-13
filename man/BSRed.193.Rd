\name{BSRed.193}
\alias{BSRed.193}
\docType{data}
\title{
  Atlantic salmon genotype data with mainly MSV-5 markers
}
\description{
  This data set contains data for 193 markers genotyped for
  3230 Atlantic salmon half-sib family individuals. A large part of the
  markers are multisite variants segregating in both paralogs (MSV-5's)
}
\usage{data(BSRed.193)}
\format{
  The format is:
Formal class 'AlleleSetIllumina' [package \pkg{beadarrayMSV}] with 7 slots\cr
  ..@ assayData        : List of 6\cr
  .. ..$ intensity        : num [1:193, 1:3230] 7.05 6.17 2.94 4.28 4.23 ...\cr
  .. ..$ theta            : num [1:193, 1:3230] 0.3469 0.4952 0.7389 -0.0202 0.3441 ...\cr
  .. ..$ SE               : num [1:193, 1:3230] 0.00582 0.00402 0.01764 0.00941 0.01083 ...\cr
  .. ..$ call             : num [1:193, 1:3230] 0.25 0.75 0.75 0 0.25 1 0.75 0.5 0 0.75 ...\cr
  .. ..$ ped.check        : logi [1:193, 1:3230] TRUE NA TRUE TRUE TRUE TRUE ...\cr
  .. ..$ ped.check.parents: num [1:193, 1:3230] 0 0 0 0 0 0 0 0 0 0 ...\cr
  .. .. ..- attr(*, "dimnames")=List of 2\cr
  .. .. .. ..$ : chr [1:193] "AY388579_a" "AY388580_a" "ESTNV_14208_491" ...\cr
  .. .. .. ..$ : chr [1:3230] "X4469076125_A" "X4469076125_B" "X4469076309_A" ...\cr
 ..@ phenoData        : Formal class 'AnnotatedDataFrame' [package \pkg{Biobase}] with 4 slots\cr
  .. .. ..@ varMetadata      :'data.frame':	14 obs. of  1 variable:\cr
  .. .. .. ..$ labelDescription: chr [1:14] "Array ID" "No. detected beads" "Chip ID" ...\cr
  .. .. ..@ data             :'data.frame':	3230 obs. of  14 variables:\cr
  .. .. .. ..$ arrayNames    : chr [1:3230] "4469076125_A" "4469076125_B" "4469076309_A" ...\cr
  .. .. .. ..$ no.beads      : int [1:3230] 558739 542929 549125 526811 511354 ...\cr
  .. .. .. ..$ chip          : num [1:3230] 4.47e+09 4.47e+09 4.47e+09 4.47e+09 4.47e+09 ...\cr
  .. .. .. ..$ row           : chr [1:3230] "A" "B" "A" "B" ...\cr
  .. .. .. ..$ col           : int [1:3230] 1 1 1 1 1 1 1 1 1 1 ...\cr
  .. .. .. ..$ noiseIntensity: num [1:3230] 0.995 1.063 0.859 0.89 1.019 ...\cr
  .. .. .. ..$ Sample.ID     : chr [1:3230] "100050151" "100050152" "100050153" ...\cr
  .. .. .. ..$ Sample.Plate  : chr [1:3230] "SMS_009" "SMS_009" "SMS_009" ...\cr
  .. .. .. ..$ Sample.Name   : chr [1:3230] "017_532_0385" "017_532_0386" "017_532_0387" ...\cr
  .. .. .. ..$ AMP.Plate     : chr [1:3230] "WG0011117-MSA2" "WG0011117-MSA2" ...\cr
  .. .. .. ..$ Sample.Well   : chr [1:3230] "E01" "F01" "G01" ...\cr
  .. .. .. ..$ Parent1       : chr [1:3230] "100000000" "100000000" "100000000"  ...\cr
  .. .. .. ..$ Parent2       : chr [1:3230] "100050100" "100050100" "100050100"  ...\cr
  .. .. .. ..$ PedigreeID    : chr [1:3230] "199950151" "199950152" "199950153" ...\cr
  ..@ featureData      : Formal class 'AnnotatedDataFrame' [package \pkg{Biobase}] with 4 slots\cr
  .. .. ..@ varMetadata      :'data.frame':	16 obs. of  1 variable:\cr
  .. .. .. ..$ labelDescription: chr [1:16] "" "Marker ID" "Polymorphism" ...\cr
  .. .. ..@ data             :'data.frame':	193 obs. of  16 variables:\cr
  .. .. .. ..$ Index         : int [1:193] 2 3 256 426 640 ...\cr
  .. .. .. ..$ Name          : chr [1:193] "AY388579_a" "AY388580_a" "ESTNV_14208_491" ...\cr
  .. .. .. ..$ SNP           : chr [1:193] "[A/G]" "[T/G]" "[T/C]" ...\cr
  .. .. .. ..$ ILMN.Strand   : chr [1:193] "TOP" "BOT" "BOT" ...\cr
  .. .. .. ..$ Address       : int [1:193] 7560672 6370541 6660563 2190240 3140563 ...\cr
  .. .. .. ..$ Address2      : int [1:193] 0 0 0 0 0 0 3120064 0 ...\cr
  .. .. .. ..$ Norm.ID       : int [1:193] 1 2 2 2 2 2 102 2 ...\cr
  .. .. .. ..$ Classification: chr [1:193] "MSV-5" "FAIL" "MSV-5" ...\cr
  .. .. .. ..$ Cent.Deviation: num [1:193] 0.2315 0.3952 0.0796 0.018 0.0863 ...\cr
  .. .. .. ..$ Within.SD     : num [1:193] 0.0258 0.0176 0.0494 0.0188 0.0332 ...\cr
  .. .. .. ..$ HW.Chi2       : num [1:193] 0.524 8.113 9.541 NA 7.628 ...\cr
  .. .. .. ..$ HW.P          : num [1:193] 0.9135 0.0437 0.0229 NA 0.0544 ...\cr
  .. .. .. ..$ BAF.Locus1    : num [1:193] 0.508 0.819 0.887 NA 0.285 ...\cr
  .. .. .. ..$ BAF.Locus2    : num [1:193] 0.508 0.729 0.359 NA 0.126 ...\cr
  .. .. .. ..$ Call.Rate     : num [1:193] 0.981 0.912 0.95 0.98 0.978 ...\cr
  .. .. .. ..$ Manual.Calls.R: chr [1:193] "MSV-5" "MSV-5" "MSV-5" ...\cr
  ..@ experimentData   :Formal class 'MIAME' [package \pkg{Biobase}]\cr
  ..@ annotation       : chr(0) 
  ..@ protocolData     :Formal class 'AnnotatedDataFrame' [package \pkg{Biobase}] \cr
  ..@ .__classVersion__:Formal class 'Versions' [package \pkg{Biobase}]\cr
}
%\details{
%}
\source{
  L. Gidskehaug, M. Kent, B. J. Hayes, and S. Lien. (2010) Genotype calling and
  mapping of multisite variants using an Atlantic salmon iSelect
  SNP-array. \emph{Bioinformatics}, doi: 10.1093/bioinformatics/btq673
}
%\references{
%}
\examples{
data(BSRed.193)
print(BSRed.193)
varMetadata(BSRed.193)
fvarMetadata(BSRed.193)
assayData(BSRed.193)$call[1:10,1:4]

\dontrun{
plotGenotypes(BSRed.193,markers=1:12)
}
}
\keyword{datasets}
