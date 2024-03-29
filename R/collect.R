
# == title
# Collect plots from ConsensusPartitionList object
#
# == param
# -object A `ConsensusPartitionList-class` object from `run_all_consensus_partition_methods`.
# -k Number of subgroups.
# -fun Function used to generate plots. Valid functions are `consensus_heatmap`,
#        `plot_ecdf`, `membership_heatmap`, `get_signatures` and `dimension_reduction`.
# -top_value_method A vector of top-value methods.
# -partition_method A vector of partitioning methods.
# -verbose Whether to print message.
# -mc.cores Number of cores. This argument will be removed in figure versions.
# -cores Number of cores, or a ``cluster`` object returned by `parallel::makeCluster`.
# -... other Arguments passed to corresponding ``fun``.
#
# == details
# Plots for all combinations of top-value methods and parittioning methods are arranged in one single page.
#
# This function makes it easy to directly compare results from multiple methods. 
#
# == value
# No value is returned.
#
# == seealso
# `collect_plots,ConsensusPartition-method` collects plots for a single `ConsensusPartition-class` object.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == example
# \donttest{
# data(golub_cola)
# collect_plots(cola_rl, k = 3)
# collect_plots(cola_rl, k = 3, fun = membership_heatmap)
# collect_plots(cola_rl, k = 3, fun = get_signatures)
# }
setMethod(f = "collect_plots",
	signature = "ConsensusPartitionList",
	definition = function(object, k = 2, fun = consensus_heatmap,
	top_value_method = object@top_value_method, 
	partition_method = object@partition_method, 
	verbose = TRUE, mc.cores = 1, cores = mc.cores, ...) {

	nv = length(dev.list())
	# on.exit({
	# 	nv2 = length(dev.list())
	# 	while(nv2 > nv & nv2 > 1) {
	# 		dev.off2()
	# 		nv2 = length(dev.list())
	# 	}
	# })

	fun_name = deparse(substitute(fun))
	
	comb = expand.grid(seq_along(top_value_method), seq_along(partition_method))
	comb = comb[order(comb[, 1], comb[, 2]), , drop = FALSE]

	if(identical(fun, plot_ecdf) || fun_name %in% c("plot_ecdf", "dimension_reduction")) {
		image_width = 500
		image_height = 500
		resolution = 150
	} else {
		image_width = 800
		image_height = 800
		resolution = NA
	}

	if(!multicore_supported() || TRUE) {
		if(get_nc(cores) > 1 && verbose) qqcat("* `cores` is reset to 1 because multi-core is not supported for generating plots.\n")
		cores = 1
	}
	
	# param <- SnowParam(workers = cores, type = "SOCK")
	# registerDoParallel(cores)
	# dev.null()
	# image <- foreach(ind = seq_len(nrow(comb))) %dopar% {
	image = lapply(seq_len(nrow(comb)), function(ind) {
		i = comb[ind, 1]
		j = comb[ind, 2]

		fun_name = fun_name

		if(verbose) qqcat("* applying @{fun_name}() for @{top_value_method[i]}:@{partition_method[j]}.\n")
	    res = object[top_value_method[i], partition_method[j]]

		if(is.null(.ENV$TEMP_DIR)) {
			file_name = tempfile(fileext = ".png", tmpdir = ".")
	        png(file_name, width = image_width, height = image_height, res = resolution)
	        oe = try(fun(res, k = k, internal = TRUE, use_raster = TRUE, ...), silent = TRUE)
	        dev.off2()
	        if(!inherits(oe, "try-error")) {
				return(structure(file_name, cache = FALSE))
		    } else {
		    	return(structure(NA, error = oe))
		    }
		} else {
			png_file = qq("@{top_value_method[i]}_@{partition_method[j]}_@{fun_name}_@{k}_@{digest(res@column_index)}.png")
			if("hash" %in% slotNames(res)) {
				png_file = qq("@{res@hash}_@{png_file}")
			}
			file_name = file.path(.ENV$TEMP_DIR, png_file)
			if(file.exists(file_name)) {
				if(verbose) qqcat("  - use cache png: @{png_file}.\n")
				return(structure(file_name, cache = TRUE))
			} else {
				png(file_name, width = image_width, height = image_height, res = resolution)
		        oe = try(fun(res, k = k, internal = TRUE, use_raster = TRUE, ...), silent = TRUE)
		        dev.off2()
		        if(!inherits(oe, "try-error")) {
					return(structure(file_name, cache = TRUE))
			    } else {
			    	return(structure(NA, error = oe))
			    }
			}
		}
	})
	# stopImplicitCluster()
	# dev.off2()

	if(any(sapply(image, inherits, "try-error"))) {
		print(image)
		stop_wrap("You have errors when generating the plots.")
	}

	grid.newpage()
	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
	pushViewport(viewport(layout = grid.layout(nrow = length(top_value_method)+1, 
	    ncol = length(partition_method)+1,
	    widths = unit.c(2*grobHeight(textGrob("foo")), unit(rep(1, length(partition_method)), "null")),
	    heights = unit.c(2*grobHeight(textGrob("foo")), unit(rep(1, length(top_value_method)), "null")))))
	for(i in seq_along(top_value_method)) {
	    pushViewport(viewport(layout.pos.row = i+1, layout.pos.col = 1))
	    grid.text(top_value_method[i], rot = 90)
	    upViewport()
	}
	for(j in seq_along(partition_method)) {
	    pushViewport(viewport(layout.pos.row = 1, layout.pos.col = j+1))
	    if(identical(fun, plot_ecdf)) {
	    	grid.text(qq("@{partition_method[j]}"))
	    } else{
	    	grid.text(qq("@{partition_method[j]} (k = @{k})"))
	    }
	    upViewport()
	}

	for(ind in seq_len(nrow(comb))) {
		i = comb[ind, 1]
		j = comb[ind, 2]

    	pushViewport(viewport(layout.pos.row = i + 1, layout.pos.col = j + 1))
    	if(is.na(image[[ind]])) {
    		qqcat("* Caught an error for @{top_value_method[i]}:@{partition_method[j]}:\n@{attr(image[[ind]], 'error')}\n")
    	} else {
    		# if(verbose) qqcat("  - reading @{image[[ind]]}\n")
    		pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
			grid.raster(readPNG(image[[ind]]))
			if(!attr(image[[ind]], "cache")) {
				file.remove(image[[ind]])
				# if(verbose) qqcat("  - removing @{image[[ind]]}\n")
			}
			popViewport()
		}
		
	    grid.rect(gp = gpar(fill = "transparent", col = "black"))
	    popViewport()
	}

	popViewport()
	popViewport()
})

# == title
# Collect plots from ConsensusPartition object
#
# == param
# -object A `ConsensusPartition-class` object.
# -verbose Whether print messages.
# 
# == details
# Plots by `plot_ecdf`, `collect_classes,ConsensusPartition-method`, `consensus_heatmap`, `membership_heatmap` 
# and `get_signatures` are arranged in one single page, for all avaialble k.
#
# == value
# No value is returned.
#
# == seealso
# `collect_plots,ConsensusPartitionList-method` collects plots for the `ConsensusPartitionList-class` object.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == example
# \donttest{
# data(golub_cola)
# collect_plots(golub_cola["ATC", "skmeans"])
# }
setMethod(f = "collect_plots",
	signature = "ConsensusPartition",
	definition = function(object, verbose = TRUE) {

	nv = length(dev.list())
	# on.exit({
	# 	nv2 = length(dev.list())
	# 	while(nv2 > nv && nv2 > 1) {
	# 		dev.off2()
	# 		nv2 = length(dev.list())
	# 	}
	# })

	qqcat = function(...) {
		message(qq(...))
	}

	all_k = object@k
	grid.newpage()
	text_height = grobHeight(textGrob("foo"))
	layout_ncol = 1+max(c(2, length(all_k)))
	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
	pushViewport(viewport(layout = grid.layout(nrow = 4+2, ncol = layout_ncol,
		widths = unit.c(2*text_height, unit(rep(1, layout_ncol - 1), "null")),
		heights = unit.c(2*text_height, unit(1, "null"), 2*text_height, unit(rep(1, 3), "null")))))
	
	# first row are two names
	pushViewport(viewport(layout.pos.row = 1, layout.pos.col = 2))
	grid.text("ECDF")
	upViewport()
	pushViewport(viewport(layout.pos.row = 1, layout.pos.col = 3))
	grid.text("consensus classes at each k")
	upViewport()

	# ecdf
	if(verbose) cat("* plotting empirical cumulative distribution curves of the consensus matrix.\n")
	pushViewport(viewport(layout.pos.row = 2, layout.pos.col = 2))
	file_name = tempfile()
	# image_width = convertWidth(unit(1, "npc"), "bigpts", valueOnly = TRUE)
 #    image_height = convertHeight(unit(1, "npc"), "bigpts", valueOnly = TRUE)
	
    png(file_name, width = 500, height = 500, res = 150)
    oe = try(plot_ecdf(object))
    dev.off2()
    if(!inherits(oe, "try-error")) {
    	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
    	grid.raster(readPNG(file_name))
    	popViewport()
    }
    grid.rect(gp = gpar(fill = "transparent"))
    upViewport()
    if(file.exists(file_name)) file.remove(file_name)
	
	image_width = 800
	image_height = 800
	if(verbose) cat("* plotting consensus classes for all k.\n")
	pushViewport(viewport(layout.pos.row = 2, layout.pos.col = 3))
	file_name = tempfile()
    png(file_name, width = image_width, height = image_height)
    oe = try(collect_classes(object, internal = TRUE))
    dev.off2()
    if(!inherits(oe, "try-error")) {
    	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
        grid.raster(readPNG(file_name))
        popViewport()
    }
    grid.rect(gp = gpar(fill = "transparent"))
    upViewport()
    if(file.exists(file_name)) file.remove(file_name)

    # pac = get_stats(object, k = all_k)[, "PAC"]
    # border_color = ifelse(pac < 0.1, "red", "black")
    border_color = rep("black", length(all_k))
	
	pushViewport(viewport(layout.pos.row = 4, layout.pos.col = 1))
	grid.text("consensus heatmap", rot = 90)
	upViewport()
	pushViewport(viewport(layout.pos.row = 5, layout.pos.col = 1))
	grid.text("membership heatmap", rot = 90)
	upViewport()
	pushViewport(viewport(layout.pos.row = 6, layout.pos.col = 1))
	grid.text("signature heatmap", rot = 90)
	upViewport()

	top_value_method = object@top_value_method
	partition_method = object@partition_method
	for(i in seq_along(all_k)) {
		pushViewport(viewport(layout.pos.row = 3, layout.pos.col = i + 1))
		grid.text(qq("k = @{all_k[i]}"))
		upViewport()

		if(verbose) qqcat("* making consensus heatmap for k = @{all_k[i]}.\n")
		pushViewport(viewport(layout.pos.row = 4, layout.pos.col = i + 1))

		if(is.null(.ENV$TEMP_DIR)) {
			file_name = tempfile(fileext = ".png", tmpdir = ".")
	        png(file_name, width = image_width, height = image_height)
	        oe = try(consensus_heatmap(object, k = all_k[i], internal = TRUE))
	        dev.off2()
	        if(!inherits(oe, "try-error")) {
	        	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
				grid.raster(readPNG(file_name))
				popViewport()
		    } else {
		    	qqcat("* Caught an error for consensus_heatmap:@{top_value_method}:@{partition_method}:\n@{oe}.\n")
		    }
		    if(file.exists(file_name)) file.remove(file_name)
		} else {
			png_file = qq("@{top_value_method}_@{partition_method}_consensus_heatmap_@{all_k[i]}_@{digest(object@column_index)}.png")
			file_name = file.path(.ENV$TEMP_DIR, png_file)
			if("hash" %in% slotNames(object)) {
				png_file = qq("@{object@hash}_@{png_file}")
			}
			if(file.exists(file_name)) {
				if(verbose) qqcat("  - use cache png: @{png_file}.\n")
				pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
				grid.raster(readPNG(file_name))
				popViewport()
			} else {
				png(file_name, width = image_width, height = image_height)
		        oe = try(consensus_heatmap(object, k = all_k[i], internal = TRUE))
		        dev.off2()
		        if(!inherits(oe, "try-error")) {
		        	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
					grid.raster(readPNG(file_name))
					popViewport()
			    } else {
			    	qqcat("* Caught an error for consensus_heatmap:@{top_value_method}:@{partition_method}:\n@{oe}.\n")
			    }
			}
		}

		grid.rect(gp = gpar(fill = "transparent", col = border_color[i]))
	    upViewport()

	    if(verbose) qqcat("* making membership heatmap for k = @{all_k[i]}.\n")
	    pushViewport(viewport(layout.pos.row = 5, layout.pos.col = i + 1))
	    
	    if(is.null(.ENV$TEMP_DIR)) {
			file_name = tempfile(fileext = ".png", tmpdir = ".")
	        png(file_name, width = image_width, height = image_height)
	        oe = try(membership_heatmap(object, k = all_k[i], internal = TRUE))
	        dev.off2()
	        if(!inherits(oe, "try-error")) {
	        	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
				grid.raster(readPNG(file_name))
				popViewport()
		    } else {
		    	qqcat("* Caught an error for membership_heatmap:@{top_value_method}:@{partition_method}:\n@{oe}.\n")
		    }
		    if(file.exists(file_name)) file.remove(file_name)
		} else {
			png_file = qq("@{top_value_method}_@{partition_method}_membership_heatmap_@{all_k[i]}_@{digest(object@column_index)}.png")
			file_name = file.path(.ENV$TEMP_DIR, png_file)
			if("hash" %in% slotNames(object)) {
				png_file = qq("@{object@hash}_@{png_file}")
			}
			if(file.exists(file_name)) {
				if(verbose) qqcat("  - use cache png: @{png_file}.\n")
				pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
				grid.raster(readPNG(file_name))
				popViewport()
			} else {
				png(file_name, width = image_width, height = image_height)
		        oe = try(membership_heatmap(object, k = all_k[i], internal = TRUE))
		        dev.off2()
		        if(!inherits(oe, "try-error")) {
		        	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
					grid.raster(readPNG(file_name))
					popViewport()
			    } else {
			    	qqcat("* Caught an error for membership_heatmap:@{top_value_method}:@{partition_method}:\n@{oe}.\n")
			    }
			}
		}

		grid.rect(gp = gpar(fill = "transparent", col = border_color[i]))
	    upViewport()

	    if(verbose) qqcat("* making signature heatmap for k = @{all_k[i]}.\n")
	    pushViewport(viewport(layout.pos.row = 6, layout.pos.col = i + 1))
	    
	    if(is.null(.ENV$TEMP_DIR)) {
			file_name = tempfile(fileext = ".png", tmpdir = ".")
	        png(file_name, width = image_width, height = image_height)
	        oe = try(get_signatures(object, k = all_k[i], internal = TRUE, use_raster = TRUE, verbose = FALSE))
	        dev.off2()
	        if(!inherits(oe, "try-error")) {
	        	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
				grid.raster(readPNG(file_name))
				popViewport()
		    } else {
		    	qqcat("* Caught an error for get_signatures:@{top_value_method}:@{partition_method}:\n@{oe}.\n")
		    }
		    if(file.exists(file_name)) file.remove(file_name)
		} else {
			png_file = qq("@{top_value_method}_@{partition_method}_get_signatures_@{all_k[i]}_@{digest(object@column_index)}.png")
			file_name = file.path(.ENV$TEMP_DIR, png_file)
			if("hash" %in% slotNames(object)) {
				png_file = qq("@{object@hash}_@{png_file}")
			}
			if(file.exists(file_name)) {
				if(verbose) qqcat("  - use cache png: @{png_file}.\n")
				pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
				grid.raster(readPNG(file_name))
				popViewport()
			} else {
				png(file_name, width = image_width, height = image_height)
		        oe = try(get_signatures(object, k = all_k[i], internal = TRUE, use_raster = TRUE, verbose = FALSE))
		        dev.off2()
		        if(!inherits(oe, "try-error")) {
		        	pushViewport(viewport(width = unit(1, "npc") - unit(2, "mm"), height = unit(1, "npc") - unit(2, "mm")))
					grid.raster(readPNG(file_name))
					popViewport()
			    } else {
			    	qqcat("* Caught an error for get_signatures:@{top_value_method}:@{partition_method}:\n@{oe}.\n")
			    }
			}
		}

		grid.rect(gp = gpar(fill = "transparent", col = border_color[i]))
	    upViewport()
	}
	upViewport()
	upViewport()

	if(verbose) {
		cat("
All individual plots can be made by following functions:
- plot_ecdf(object)
- collect_classes(object)
- consensus_heatmap(object, k)
- membership_heatmap(object, k)
- get_signatures(object, k)
")
	}
})

# == title
# Collect classes from ConsensusPartitionList object
#
# == param
# -object A `ConsensusPartitionList-class` object returned by `run_all_consensus_partition_methods`.
# -k Number of subgroups.
# -show_column_names Whether to show column names in the heatmap (which is the column name in the original matrix).
# -column_names_gp Graphics parameters for column names.
# -anno A data frame of annotations for the original matrix columns. 
#       By default it uses the annotations specified in `run_all_consensus_partition_methods`.
# -anno_col A list of colors (color is defined as a named vector) for the annotations. If ``anno`` is a data frame,
#       ``anno_col`` should be a named list where names correspond to the column names in ``anno``.
# -simplify Internally used.
# -... Pass to `ComplexHeatmap::draw,HeatmapList-method`.
#
# == details
# There are following panels in the plot:
#
# - a heatmap showing partitions predicted from all methods where the top annotation
#   is the consensus partition summarized from partitions from all methods, weighted
#   by mean silhouette scores in every single method.
# - a row barplot annotation showing the mean silhouette scores for different methods.
#
# The row clustering is applied on the dissimilarity matrix calculated by `clue::cl_dissimilarity` with the ``comembership`` method.
# 
# The brightness of the color corresponds to the silhouette scores for the consensus partition in each method. 
#
# == value
# No value is returned.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == example
# data(golub_cola)
# collect_classes(golub_cola, k = 3)
setMethod(f = "collect_classes",
	signature = "ConsensusPartitionList",
	definition = function(object, k, show_column_names = FALSE,
	column_names_gp = gpar(fontsize = 8),
	anno = get_anno(object), anno_col = get_anno_col(object), 
	simplify = FALSE, ...) {

	if(missing(k)) stop_wrap("k needs to be provided.")

	top_value_method = object@top_value_method
	partition_method = object@partition_method

	top_value_method_vec = NULL
	partition_method_vec = NULL
	class_mat = NULL
	silhouette_mat = NULL
	for(i in seq_along(top_value_method)) {
	    for(j in seq_along(partition_method)) {  
	    	res = object[top_value_method[i], partition_method[j]]

	        top_value_method_vec = c(top_value_method_vec, top_value_method[i])
	        partition_method_vec = c(partition_method_vec, partition_method[j])
	        class_df = get_classes(res, k)
	        class_mat = cbind(class_mat, class_df[, "class"])
	        silhouette_mat = cbind(silhouette_mat, class_df[, "silhouette"])
	    }
	}

	class_mat = as.matrix(class_mat)
	colnames(class_mat) = paste(top_value_method_vec, partition_method_vec, sep = ":")
	rownames(class_mat) = rownames(class_df)
	ik = which(res@k == k)
	
	silhouette_mat = as.matrix(silhouette_mat)
	silhouette_mat[silhouette_mat < 0] = 0

	adjust_by_transparency = function(col, transparency) {
		rgb( 1 - (1 - t(col2rgb(col)/255)) * (1 - transparency))
	}

	consensus_class = get_classes(object, k = k)$class
	m = t(class_mat)
	column_order = column_order_by_group(consensus_class, m)

	if(is.null(anno)) {
		bottom_anno = NULL
	} else {
		if(is.atomic(anno)) {
			anno_nm = deparse(substitute(anno))
			anno = data.frame(anno)
			colnames(anno) = anno_nm
			if(!is.null(anno_col)) {
				anno_col = list(anno_col)
				names(anno_col) = anno_nm
			}
		} else if(ncol(anno) == 1) {
			if(!is.null(anno_col)) {
				if(is.atomic(anno_col)) {
					anno_col = list(anno_col)
					names(anno_col) = colnames(anno)
				}
			}
		}

		if(is.null(anno_col)) {
			bottom_anno = HeatmapAnnotation(df = anno,
				show_annotation_name = TRUE, annotation_name_side = "left")
		} else {
			bottom_anno = HeatmapAnnotation(df = anno, col = anno_col,
				show_annotation_name = TRUE, annotation_name_side = "left")
		}
	}

	pl = lapply(object@list[paste(top_value_method_vec, partition_method_vec, sep = ":")], function(x) as.cl_partition(get_membership(x, k = k)))
	clen = cl_ensemble(list = pl)
	m_diss = cl_dissimilarity(clen, method = "comembership")

	ht = Heatmap(m, name = "Class", col = cola_opt$color_set_2, column_order = column_order,
		show_column_names = show_column_names, column_names_gp = column_names_gp,
		column_title = qq("classification from all @{nrow(m)} methods, k = @{k}"),
		row_names_side = "left", cluster_rows = {if(nrow(m) == 1) FALSE else hclust(m_diss)}, 
		cluster_columns = FALSE, row_title = NULL,
		show_column_dend = FALSE, rect_gp = gpar(type = "none"),
		layer_fun = function(j, i, x, y, w, h, fill) {
			col = adjust_by_transparency(fill, 1 - pindex(silhouette_mat, j, i))
			grid.rect(x, y, w, h, gp = gpar(fill = col, col = col))
		},
		top_annotation = HeatmapAnnotation(consensus_class = consensus_class, 
			col = list(consensus_class = cola_opt$color_set_2),
			show_annotation_name = TRUE, annotation_name_side = "left", show_legend = FALSE),
		bottom_annotation = bottom_anno,
		left_annotation = rowAnnotation("Top-value method" = top_value_method_vec, 
			"Partition method" = partition_method_vec,
			annotation_name_side = "bottom",
			col = list("Top-value method" = structure(names = top_value_method, cola_opt$color_set_1[seq_along(top_value_method)]),
			           "Partition method" = structure(names = partition_method, cola_opt$color_set_2[seq_along(partition_method)])),
			width = unit(10, "mm"),
			show_annotation_name = FALSE))
	if(simplify) {
		ht@left_annotation = NULL
	}
	stat = get_stats(object, k = k)[colnames(class_mat), "1-PAC"]
	is_stable_k = is_stable_k(object, k = k)[colnames(class_mat)]
	ht = ht + rowAnnotation("1-PAC" = row_anno_barplot(stat, gp = gpar(fill = ifelse(is_stable_k, "red", "grey")), baseline = 0, axis = TRUE),
			width = unit(2, "cm"))
	draw(ht, heatmap_legend_list = list(Legend(title = "Barplot", labels = c("Stable partition", "unstable partition"), legend_gp = gpar(fill = c("red", "grey"), pch = 15))), ...)
})


# == title
# Collect subgroups from ConsensusPartition object
#
# == param
# -object A `ConsensusPartition-class` object.
# -internal Used internally.
# -show_row_names Whether to show row names in the heatmap (which is the column name in the original matrix).
# -row_names_gp Graphics parameters for row names.
# -anno A data frame of annotations for the original matrix columns. 
#       By default it uses the annotations specified in `consensus_partition` or `run_all_consensus_partition_methods`.
# -anno_col A list of colors (color is defined as a named vector) for the annotations. If ``anno`` is a data frame,
#       ``anno_col`` should be a named list where names correspond to the column names in ``anno``.
#
# == details
# The percent membership matrix and the subgroup labels for each k are plotted in the heatmaps.
#
# Same row in all heatmaps corresponds to the same column in the original matrix.
#
# == value
# No value is returned.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == example
# data(golub_cola)
# collect_classes(golub_cola["ATC", "skmeans"])
setMethod(f = "collect_classes",
	signature = "ConsensusPartition",
	definition = function(object, internal = FALSE, 
	show_row_names = FALSE, row_names_gp = gpar(fontsize = 8),
	anno = object@anno, anno_col = object@anno_col) {

	all_k = object@k

	ht_list = NULL
	gap = NULL
	class_mat = NULL
	for(i in seq_along(all_k)) {
		membership = object@object_list[[i]]$membership
		class = object@object_list[[i]]$class_df$class

		ht_list = ht_list + Heatmap(membership, col = colorRamp2(c(0, 1), c("white", "red")),
			show_row_names = FALSE, cluster_columns = FALSE, cluster_rows = FALSE, show_heatmap_legend = i == 1,
			show_column_names = !internal,
			heatmap_legend_param = list(title = "Prob"),
			column_title = ifelse(internal, "", qq("k = @{all_k[i]}")),
			name = paste0("membership_", all_k[i])) + 
			Heatmap(class, col = cola_opt$color_set_2, 
				show_row_names = FALSE, show_heatmap_legend = i == length(all_k), 
				show_column_names = !internal,
				heatmap_legend_param = list(title = "Class"),
				name = paste(all_k[i], "_classes"))
		gap = c(gap, c(0, 4))
		class_mat = cbind(class_mat, as.numeric(class))
	}

	if(!is.null(anno)) {
		if(is.atomic(anno)) {
			anno_nm = deparse(substitute(anno))
			anno = data.frame(anno)
			colnames(anno) = anno_nm
			if(!is.null(anno_col)) {
				anno_col = list(anno_col)
				names(anno_col) = anno_nm
			}
		} else if(ncol(anno) == 1) {
			if(!is.null(anno_col)) {
				if(is.atomic(anno_col)) {
					anno_col = list(anno_col)
					names(anno_col) = colnames(anno)
				}
			}
		}
		if(is.null(anno_col))
			ht_list = ht_list + rowAnnotation(df = anno, show_annotation_name = !internal)
		else {
			ht_list = ht_list + rowAnnotation(df = anno, col = anno_col, show_annotation_name = !internal)
		}
		gap = c(gap, 4)
	}

	if(!internal & show_row_names) {
		rn = rownames(membership)
		ht_list = ht_list + rowAnnotation(nm = anno_text(rn, gp = row_names_gp))
		gap[length(gap)] = 1
	}

    draw(ht_list, gap = unit(gap, "mm"), row_order = do.call("order", as.data.frame(class_mat)),
    	# column_title = qq("classes from k = '@{paste(all_k, collapse = ', ')}'"),
    	show_heatmap_legend = !internal, show_annotation_legend = !internal)

    for(k in all_k) {
    	ik = which(all_k == k )
    	# border_color = ifelse(object@object_list[[ik]]$stat$PAC < 0.1, "red", "black")
    	border_color = rep("black", length(all_k))
    	decorate_heatmap_body(paste0("membership_", k), {
    		grid.rect(0, width = unit(1+1/k, "npc"), just = "left", gp = gpar(col = border_color, fill = "transparent"))
    	})
    }
})

# == title
# Draw and compare statistics for a single method
#
# == param
# -object A `ConsensusPartition-class` object.
# -... Other arguments.
#
# == details
# It is identical to `select_partition_number,ConsensusPartition-method`.
#
setMethod(f = "collect_stats",
	signature = "ConsensusPartition",
	definition = function(object, ...) {

	select_partition_number(object, ...)
})


# == title
# Draw and compare statistics for multiple methods
#
# == param
# -object A `ConsensusPartitionList-class` object.
# -k Number of subgroups.
# -layout_nrow Number of rows in the layout
# -all_stats Whether to show all statistics that were calculated. Used internally.
# -... Other arguments
#
# == details
# It draws heatmaps for statistics for multiple methods in parallel, so that users can compare which combination
# of methods gives the best results with given the number of subgroups.
#
# == examples
# data(golub_cola)
# collect_stats(golub_cola, k = 3)
setMethod(f = "collect_stats",
	signature = "ConsensusPartitionList",
	definition = function(object, k, layout_nrow = 2, all_stats = FALSE, ...) {

	if(missing(k)) stop_wrap("k needs to be provided.")

	stats = get_stats(object, k = k, all_stats = all_stats)

	all_top_value_methods = object@top_value_method
	all_parittion_methods = object@partition_method

	all_stat_nm = STAT_USED

	grid.newpage()
	layout_ncol = ceiling(length(all_stat_nm)/layout_nrow)
	pushViewport(viewport(layout = grid.layout(nrow = layout_nrow, ncol = layout_ncol)))
	layout_ir = 1
	layout_ic = 1
	for(nm in all_stat_nm) {
		m = matrix(nrow = length(all_top_value_methods), ncol = length(all_parittion_methods), dimnames = list(all_top_value_methods, all_parittion_methods))
		for(rn in rownames(m)) {
			for(cn in colnames(m)) {
				m[rn, cn] = stats[paste0(rn, ":", cn), nm]
			}
		}

		pushViewport(viewport(layout.pos.row = layout_ir, layout.pos.col = layout_ic))
		if(nm %in% c( "1-PAC", "mean_silhouette", "concordance")) {
			col_fun = colorRamp2(c(0, 0.5, 1), c("blue", "white", "red"))
		} else {
			col_fun = colorRamp2(c(min(m), (min(m) + max(m))/2, max(m)), c("blue", "white", "red"))
		}
		ht = Heatmap(m, name = nm, col = col_fun, cluster_rows = FALSE, cluster_columns = FALSE, rect_gp = gpar(type = "none"),
			layer_fun = function(j, i, x, y, w, h, fill) {
				v = pindex(m, i, j)
				w = as.numeric(w)[1]
				h = as.numeric(h)[1]
				grid.rect(x, y, w, h, gp = gpar(fill = "#EFEFEF", col = "white", lwd = 2))
				r = unit(min(w, h)*0.45*v, "snpc")
				# grid.circle(x, y, r = r, gp = gpar(fill = fill))
				grid.rect(x, y, width = r*2, height = r*2, gp = gpar(fill = fill))
				grid.text(sprintf("%.2f", v), x, y, gp = gpar(fontsize = 0.45*as.numeric(convertHeight(r*2, "points"))))
			}, column_title = "    ", column_title_side = "bottom", column_title_gp = gpar(fontsize = 18),
			column_names_side = "top", column_names_rot = 45, 
			show_heatmap_legend = FALSE)
		lgd = Legend(col_fun = col_fun, direction = "horizontal", title = qq("@{nm} (k = @{k})"), title_position = "lefttop")
		draw(ht, newpage = FALSE)
		decorate_column_title(nm, {
			draw(lgd)
		})
		popViewport()

		if(layout_ic == layout_ncol) {
			layout_ir = layout_ir + 1
			layout_ic = 1
		} else {
			layout_ic = layout_ic + 1
		}
	}
	popViewport()

})
