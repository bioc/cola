\name{get_classes-HierarchicalPartition-method}
\alias{get_classes,HierarchicalPartition-method}
\title{
Get class IDs from the HierarchicalPartition object
}
\description{
Get class IDs from the HierarchicalPartition object
}
\usage{
\S4method{get_classes}{HierarchicalPartition}(object, depth = max_depth(object))
}
\arguments{

  \item{object}{A \code{\link{HierarchicalPartition-class}} object.}
  \item{depth}{Depth of the hierarchy.}

}
\value{
A data frame of classes IDs. The class IDs are the node IDs where the subgroup sits in the hierarchy.
}
\author{
Zuguang Gu <z.gu@dkfz.de>
}
\examples{
# There is no example
NULL

}