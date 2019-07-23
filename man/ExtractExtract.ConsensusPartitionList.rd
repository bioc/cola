\name{[[.ConsensusPartitionList}
\alias{[[.ConsensusPartitionList}
\alias{ExtractExtract.ConsensusPartitionList}
\title{
Subset a ConsensusPartitionList object
}
\description{
Subset a ConsensusPartitionList object
}
\usage{
\method{[[}{ConsensusPartitionList}(x, i)
}
\arguments{

  \item{x}{A \code{\link{ConsensusPartitionList-class}} object.}
  \item{i}{Character index for combination of top-value methods and partition method in a form of e.g. \code{sd:MAD}.}

}
\value{
A \code{\link{ConsensusPartition-class}} object.
}
\author{
Zuguang Gu <z.gu@dkfz.de>
}
\examples{
data(cola_rl)
cola_rl[["sd:MAD"]]
}
