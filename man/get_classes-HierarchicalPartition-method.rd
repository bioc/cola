\name{get_classes-HierarchicalPartition-method}
\alias{get_classes,HierarchicalPartition-method}
\title{
Get class from the HierarchicalPartition object
}
\description{
Get class from the HierarchicalPartition object
}
\usage{
\S4method{get_classes}{HierarchicalPartition}(object, depth = max_depth(object))
}
\arguments{

  \item{object}{a \code{\link{HierarchicalPartition-class}} object}
  \item{depth}{minimal depth of the hierarchy}

}
\value{
A vector of predicted classes.
}
\author{
Zuguang Gu <z.gu@dkfz.de>
}
\examples{
data(cola_rh)
get_classes(cola_rh)
get_classes(cola_rh, depth = 2)
}
