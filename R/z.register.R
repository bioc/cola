
.ENV = new.env()
.ENV$ALL_TOP_VALUE_METHODS = NULL
.ENV$ALL_TOP_VALUE_FUN = list()
.ENV$ALL_PARTITION_FUN = list()
.ENV$ALL_PARTITION_METHODS = NULL

.ENV$TEMP_DIR = NULL

get_top_value_method = function(method) {
	if(!method %in% .ENV$ALL_TOP_VALUE_METHODS) {
		stop_wrap(qq("top-value method '@{method}' has not been defined yet."))
	}
	.ENV$ALL_TOP_VALUE_FUN[[method]]
}

# == title
# Register user-defined top-value methods
#
# == param
# -... a named list of functions.
# 
# == details 
# The user-defined function should accept one argument which is the data
# matrix and the scores are calculated by rows. Rows with top scores are treated
# as "top rows" in cola analysis. Following is how we register "sd" (standard deviation) top-value method:
#
#   register_top_value_methods(sd = function(mat) apply(mat, 1, sd))
#
# Of course, you can use `matrixStats::rowSds` to give a faster calculation of row sd:
#
#   register_top_value_methods(sd = rowSds)
#
# The registered top-value method will be used as defaults in `run_all_consensus_partition_methods`.
# 
# To remove a top-value method, use `remove_top_value_methods`.
#
# There are four default top-value methods:
#
# -"sd" standard deviation, by `matrixStats::rowSds`.
# -"cv" coefficient variance, calculated as ``sd/(mean+s)`` where ``s`` is the 10th percentile of all row means.
# -"MAD" median absolute deviation, by `matrixStats::rowMads`.
# -"ATC" the `ATC` method.
#
# == return
# No value is returned.
#
# == seealso
# `all_top_value_methods` lists all registered top-value methods.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
# 
# == examples 
# all_top_value_methods()
# register_top_value_methods(
#     ATC_spearman = function(mat) ATC(mat, method = "spearman"),
#     ATC_multicore = function(mat) ATC(mat, mc.cores = 2)
# )
# all_top_value_methods()
# remove_top_value_methods(c("ATC_spearman", "ATC_multicore"))
register_top_value_methods = function(...) {
	lt = list(...)
	lt1 = lt[intersect(names(lt), .ENV$ALL_TOP_VALUE_METHODS)]
	lt2 = lt[setdiff(names(lt), .ENV$ALL_TOP_VALUE_METHODS)]

	rand_mat = matrix(rnorm(10*20), nrow = 20)
	if(length(lt1)) {
		for(i in seq_along(lt1)) {
			if(length(lt1[[i]](rand_mat)) != nrow(rand_mat)) {
				stop_wrap(qq("Top-value method of @{names(lt1[i])} should return a vector with the same length of matrix rows."))
			}
		}
		.ENV$ALL_TOP_VALUE_FUN[names(lt1)] = lt1
	}
	if(length(lt2)) {
		for(i in seq_along(lt2)) {
			if(length(lt2[[i]](rand_mat)) != nrow(rand_mat)) {
				stop_wrap(qq("Top-value method of @{names(lt2[i])} should return a vector with the same length of matrix rows."))
			}
		}
		.ENV$ALL_TOP_VALUE_FUN = c(.ENV$ALL_TOP_VALUE_FUN, lt2)
	}
	.ENV$ALL_TOP_VALUE_METHODS = names(.ENV$ALL_TOP_VALUE_FUN)
}

# == title
# All supported top-value methods
#
# == details
# New top-value methods can be registered by `register_top_value_methods`.
#
# == return 
# A vector of supported top-value methods.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == examples
# all_top_value_methods()
all_top_value_methods = function() {
	.ENV$ALL_TOP_VALUE_METHODS
}

register_top_value_methods(
	sd = rowSds,
	cv = function(mat) {
		s = rowMeans(mat)
		rowSds(mat)/(s + quantile(s, 0.1))
	},
	MAD = matrixStats::rowMads,
	ATC = ATC
)

get_partition_method = function(method, partition_param = list()) {
	if(!method %in% .ENV$ALL_PARTITION_METHODS) {
		stop_wrap(qq("partition method '@{method}' has not been defined yet."))
	}
	fun = .ENV$ALL_PARTITION_FUN[[method]]

	# if sample from columns, the columns which have not been samples should be filled with NA
	fun2 = function(mat, k, column_index = seq_len(ncol(mat))) {
		partition = do.call(fun, c(list(mat[, column_index, drop = FALSE], k), partition_param))
		if(!is.atomic(partition)) {
			partition = cl_membership(partition)
			partition = as.vector(cl_class_ids(partition))
		}
		partition2 = rep(NA, ncol(mat))
		partition2[column_index] = partition

		x = as.cl_hard_partition(partition2)

		# nc = n_of_classes(x)
		# if(nc != k) {
		# 	cat(red(qq("!!! @{method}: number of classes (@{nc}) in the partition is not same as @{k} !!!\n")))
		# }

		return(x)
	}
	attr(fun2, "scale_method") = attr(fun, "scale_method")
	attr(fun2, "execution_time") = attr(fun, "execution_time")
	return(fun2)
}

# == title
# Register user-defined partition functions
#
# == param
# -... a named list of functions.
# -scale_method normally, data matrix is scaled by rows before sent to
#        the partition function. The default scaling is applied by `base::scale`.
#        However, some partition functions may not accept negative values which 
#        are produced by `base::scale`. Here ``scale_method`` can be set to ``rescale``
#        which scales rows by ``(x - min)/(max - min)``. Note here ``scale_method`` only means
#        the method to scale rows. When ``scale_rows`` is set to ``FALSE`` in `consensus_partition`
#        or `run_all_consensus_partition_methods`, there wil be no row scaling when doing partition.
#        The value for ``scale_method`` can be a vector if user specifies more than one partition function.
# 
# == details 
# The user-defined function should accept at least two arguments. The first two arguments are the data
# matrix and the number of partitions. The third optional argument should always be ``...`` so that parameters
# for the partition function can be passed by ``partition_param`` from `consensus_partition`.
# If users forget to add ``...``, it is added internally.
#
# The function should return a vector of partitions (or class labels) or an object which can be recognized by `clue::cl_membership`.
# 
# The partition function should be applied on columns (Users should be careful with this because some of the R functions apply on rows and
# some of the R functions apply on columns). E.g. following is how we register `stats::kmeans` partition method:
#
#   register_partition_methods(
#       kmeans = function(mat, k, ...) {
#           # mat is transposed because kmeans() applies on rows
#           kmeans(t(mat), centers = k, ...)$centers
#       }
#   )
#
# The registered partition methods will be used as defaults in `run_all_consensus_partition_methods`.
# 
# To remove a partition method, use `remove_partition_methods`.
#
# There are following default partition methods:
#
# -"hclust" hierarchcial clustering with Euclidean distance, later columns are partitioned by `stats::cutree`.
#           If users want to use another distance metric or clustering method, consider to register a new partition method. E.g.
#           ``register_partition_methods(hclust_cor = function(mat, k) cutree(hclust(as.dist(cor(mat)))))``.
# -"kmeans" by `stats::kmeans`.
# -"skmeans" by `skmeans::skmeans`.
# -"pam" by `cluster::pam`.
# -"mclust" by `mclust::Mclust`. mclust is applied to the first three principle components from rows.
#
# == value
# No value is returned.
#
# == seealso
# `all_partition_methods` lists all registered partition methods.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == examples
# all_partition_methods()
# register_partition_methods(
#     random = function(mat, k) sample(k, ncol(mat), replace = TRUE)
# )
# all_partition_methods()
# remove_partition_methods("random")
register_partition_methods = function(..., scale_method = c("standardization", "rescale", "none")) {
	
	scale_method = match.arg(scale_method)[1]
	lt = list(...)
	lt = lapply(lt, function(fun) {
		# just in case people forgot to add the ...
		if(length(formals(fun)) == 2) {
			function(mat, k, ...) {
				fun(mat, k)
			}
		} else {
			fun
		}
	})
	for(i in seq_along(lt)) {
		attr(lt[[i]], "scale_method") = scale_method
	}

	m = matrix(rnorm(100), 10)
	if(scale_method == "standardization") {
		m2 = m
	} else if(scale_method == "rescale") {
		m2 = t(apply(m, 1, function(x) {
			(x - min(x))/(max(x) - min(x))
		}))
	} else {
		m2 = m
	}
	for(i in seq_along(lt)) {
		t = microbenchmark(foo <- lt[[i]](m2, 2), times = 1)
		attr(lt[[i]], "execution_time") = mean(t$time)
	}

	lt1 = lt[intersect(names(lt), .ENV$ALL_PARTITION_METHODS)]
	lt2 = lt[setdiff(names(lt), .ENV$ALL_PARTITION_METHODS)]
	if(length(lt1)) .ENV$ALL_PARTITION_FUN[names(lt1)] = lt1
	if(length(lt2)) .ENV$ALL_PARTITION_FUN = c(.ENV$ALL_PARTITION_FUN, lt2)
	.ENV$ALL_PARTITION_METHODS = names(.ENV$ALL_PARTITION_FUN)
}

# == title
# All supported partition methods
#
# == details
# New partition methods can be registered by `register_partition_methods`.
#
# == return 
# A vector of supported partition methods.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == examples
# all_partition_methods()
all_partition_methods = function() {
	.ENV$ALL_PARTITION_METHODS
}

register_partition_methods(
	hclust = function(mat, k, ...) {
		hc = hclust(d = dist(t(mat)), ...)
		cutree(hc, k)
	},
	kmeans = function(mat, k, ...) {
		kmeans(t(mat), centers = k, ...)
	},
	skmeans = function(mat, k, ...) {
		skmeans(x = t(mat), k = k, ...)
	},
	# hddc = function(mat, k, ...) {
	# 	i = 0
	# 	while(i < 50) {
	# 		suppressWarnings(cl <- hddc(data = t(mat), K = k, show = FALSE, ...)$class)
	# 		if(length(cl) != 0) {
	# 			return(cl)
	# 		}
	# 		i = i + 1
	# 	}
	# 	return(rep(1, ncol(mat)))
	# }, 
	pam = function(mat, k, ...) {
		pam(t(mat), k = k, ...)
	},
	# cclust = function(mat, k, ...) {
	# 	cclust(x = t(mat), centers = k, ...)
	# },
	mclust = function(mat, k, ...) {
		pca = prcomp(t(mat))
		Mclust(pca$x[, 1:3], G = k, verbose = FALSE, ...)$classification
	}
	# som = function(mat, k, ...) {
	# 	kr = floor(sqrt(ncol(mat)))
	# 	somfit = som(t(mat), grid = somgrid(kr, kr, "hexagonal"), ...)
	# 	m = somfit$codes[[1]]
	# 	m = m[seq_len(nrow(m)) %in% somfit$unit.classif, ]
	# 	cl = cutree(hclust(dist(m)), k)
	# 	group = numeric(ncol(mat))
	# 	for(cl_unique in unique(cl)) {
	# 		ind = as.numeric(gsub("V", "", names(cl)[which(cl == cl_unique)]))
	# 		l = somfit$unit.classif %in% ind
	# 		group[l] = cl_unique
	# 	}
	# 	group
	# }
)

# == title
# Register NMF partition method
#
# == param
# -package which package to support NMF, ``NMF`` package or ``NNLM`` package.
#
# == details
# Note NMF analysis is very time-consuming.
#
register_NMF = function(package = c("NMF", "NNLM")) {
	package = match.arg(package)[1]

	if(package == "NNLM") {
		if(!requireNamespace("NNLM")) {
			stop_wrap("You need to install NNLM package to support NMF.")
		}
		register_partition_methods(
			NMF = function(mat, k, ...) {
				fit = NNLM::nnmf(A = mat, k = k, verbose = FALSE, ...)
				apply(fit$H, 2, which.max)
			}, scale_method = "rescale"
		)
	} else if(package == "NMF") {
		if(!requireNamespace("NMF")) {
			stop_wrap("You need to install NMF package to support NMF.")
		}
		register_partition_methods(
			NMF = function(mat, k, ...) {
				NMF::nmf.options(maxIter = 500)
				fit = NMF::nmf(mat, rank = k)
				NMF::nmf.options(maxIter = NULL)
				apply(fit@fit@H, 2, which.max)
			}, scale_method = "rescale"
		)
	}
}

# == title
# Register SOM partition method
#
register_SOM = function() {
	register_partition_methods(
	    SOM = function(mat, k, ...) {
	        kr = floor(sqrt(ncol(mat)))
	        somfit = kohonen::som(t(mat), grid = kohonen::somgrid(kr, kr, "hexagonal"), ...)
	        m = somfit$codes[[1]]
	        m = m[seq_len(nrow(m)) %in% somfit$unit.classif, ]
	        cl = cutree(hclust(dist(m)), k)
	        group = numeric(ncol(mat))
	        for(cl_unique in unique(cl)) {
	            ind = as.numeric(gsub("V", "", names(cl)[which(cl == cl_unique)]))
	            l = somfit$unit.classif %in% ind
	            group[l] = cl_unique
	        }
	        group
	    }
	)
}

# == title
# Remove top-value methods
#
# == param
# -method name of the top-value methods to be removed.
#
# == value
# No value is returned.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
remove_top_value_methods = function(method) {
	nm_keep = setdiff(.ENV$ALL_TOP_VALUE_METHODS, method)
	.ENV$ALL_TOP_VALUE_FUN = .ENV$ALL_TOP_VALUE_FUN[nm_keep]
	.ENV$ALL_TOP_VALUE_METHODS = nm_keep
}


# == title
# Remove partition methods
#
# == param
# -method name of the partition methods to be removed.
#
# == value
# No value is returned.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
remove_partition_methods = function(method) {
	nm_keep = setdiff(.ENV$ALL_PARTITION_METHODS, method)
	.ENV$ALL_PARTITION_FUN = .ENV$ALL_PARTITION_FUN[nm_keep]
	.ENV$ALL_PARTITION_METHODS = nm_keep
}