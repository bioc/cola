\name{collect_classes-ConsensusPartitionList-method}
\alias{collect_classes,ConsensusPartitionList-method}
\title{
Collect classes from ConsensusPartitionList object
}
\description{
Collect classes from ConsensusPartitionList object
}
\usage{
\S4method{collect_classes}{ConsensusPartitionList}(object, k, show_column_names = FALSE,
    anno = get_anno(object), anno_col = get_anno_col(object))
}
\arguments{

  \item{object}{a \code{\link{ConsensusPartitionList-class}} object returned by \code{\link{run_all_consensus_partition_methods}}.}
  \item{k}{number of partitions.}
  \item{show_column_names}{whether show column names in the heatmap (which is the column name in the original matrix).}
  \item{anno}{a data frame of annotations for the original matrix columns.  By default it uses the annotations specified in \code{\link{consensus_partition}} or \code{\link{run_all_consensus_partition_methods}}.}
  \item{anno_col}{a list of colors (color is defined as a named vector) for the annotations.}

}
\details{
There are following panels in the plot:

\itemize{
  \item a heatmap showing partitions predicted from all methods where the top annotation is the consensus partition summarized from partitions from all methods, weighted by mean silhouette scores.
  \item a row barplot annotation showing the mean silhouette scores for different methods.
}

The row clustering is applied on the dissimilarity matrix calculated by \code{\link[clue]{cl_dissimilarity}} with the \code{comembership} method.

The brightness of the color corresponds to the silhouette scores for the consensus partition in each method.
}
\value{
No value is returned.
}
\author{
Zuguang Gu <z.gu@dkfz.de>
}
\examples{
data(cola_rl)
collect_classes(cola_rl, k = 3)
}
