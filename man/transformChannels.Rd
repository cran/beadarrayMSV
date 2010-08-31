\name{transformChannels}
\Rdversion{1.1}
\alias{transformChannels}
\alias{transformSEs}
\title{
  Signal transformation
}
\description{
  Signal and standard error estimates are subjected to log or nth-root transformation
}
\usage{
transformChannels(X, Y = NULL, normOpts = setNormOptions())

transformSEs(X, se.X, normOpts = setNormOptions())
}
\arguments{
  \item{X}{
    Matrix of (mean bead type) intensity data for red or green channel
  }
  \item{Y}{
    Matrix of intensity data for the alternate channel
  }
  \item{normOpts}{
    List specifying pre-processing settings. See \code{\link{setNormOptions}}
  }
  \item{se.X}{
    Matrix holding the standard error of the mean bead intensities
  }
}
\details{
  The channel(s) are transformed according to the specifications in
  \code{normOpts}.

  As signal intensities are estimated as (robust)
  means within bead-types on an array, the estimated standard
  errors are in fact standard errors of means. The standard errors of
  means cannot be log or nth-root transformed in order to get the
  standard error of the transformed signal mean. To avoid loading
  the bead-level data into the workspace, the function
  \code{transformSEs} estimates the transformed standard errors using a
  first order Taylor-expansion around the mean. In our experience, these
  estimates are accurate except for very low signal intensities (below
  noise level).
}
\value{
  The output from \code{transformChannels} or \code{transformSEs} is a
  list containg at least two of the following items
  \item{X }{Transformed X}
  \item{Y }{Transformed Y}
  \item{SE }{Estimated standard errors of transformed signal mean}
  \item{lstr }{Character string with description of transformation}
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

\seealso{
  \code{\link{preprocessBeadSet}}
}
\examples{
#Simulate intensity data
X <- matrix(exp(rnorm(4000))*100,nrow=1000,ncol=4,
    dimnames=list(1:1000,paste('Array',1:4)))
Y <- matrix(exp(rnorm(4000))*70,nrow=1000,ncol=4,
    dimnames=list(1:1000,paste('Array',1:4)))

#Transform signal
normOpts <- setNormOptions(offset=0)
trChannel <- transformChannels(X,Y,normOpts)

\dontrun{
#Plot one array before and after transformation
dev.new()
plot(X[,1],Y[,1],pch='o',main='Raw data')
dev.new()
plot(trChannel$X[,1],trChannel$Y[,1],pch='o',
    main=paste(trChannel$lstr,'transformed data'))
}

#Simulate a single bead type represented by 12 beads
beadLevelX <- rnorm(12,mean=800,sd=10) 
sd.X <- sd(beadLevelX)
X <- mean(beadLevelX)
se.X <- sd.X/sqrt(length(beadLevelX))

#Transformed signal (4th-root)
transfX <- mean(beadLevelX^(1/4))   #true value
print(transfX)
transfX.1 <- X^(1/4)                #good approximation
print(transfX.1)

#Transformed standard error (4th-root)
transfSE <- sd(beadLevelX^(1/4))/sqrt(length(beadLevelX))  #true value
print(transfSE)
transfSE.1 <- se.X^(1/4)                                   #bad approximation
print(transfSE.1)
transfSE.2 <- transformSEs(X,se.X,normOpts=normOpts)       #good approximation
print(transfSE.2$SE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
