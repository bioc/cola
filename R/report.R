

KNITR_TAB_ENV = new.env(parent = emptyenv())
KNITR_TAB_ENV$current_tab_index = 0
KNITR_TAB_ENV$header = NULL
KNITR_TAB_ENV$current_html = ""
KNITR_TAB_ENV$prefix = NULL
KNITR_TAB_ENV$css_added = FALSE

# == title
# Add JavaScript tab in the report
#
# == param
# -code R code to execute.
# -header Header or the title for the tab.
# -prefix Prefix of the chunk label.
# -desc Decription in the tab.
# -opt Options for the knitr chunk.
# -message Message to print.
# -hide_and_show Whether to hide the code output.
#
# == details
# Each tab contains the R source code and results generated from it (figure, tables, text, ...).
#
# This function is only for internal use.
#
# == value
# No value is returned.
#
# == seealso
# `knitr_insert_tabs` produces a complete HTML fragment.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
knitr_add_tab_item = function(code, header, prefix, desc = "", opt = NULL, 
	message = NULL, hide_and_show = FALSE) {

	KNITR_TAB_ENV$current_tab_index = KNITR_TAB_ENV$current_tab_index + 1
	tab = qq("tab-@{prefix}-@{KNITR_TAB_ENV$current_tab_index}")
	if(!is.null(KNITR_TAB_ENV$prefix)) {
		if(KNITR_TAB_ENV$prefix != prefix) {
			stop_wrap(qq("prefix ('@{prefix}') should be the same as the previous one ('@{KNITR_TAB_ENV$prefix}')."))
		}
	}
	KNITR_TAB_ENV$prefix = prefix

	knitr_text = qq(
"@{strrep('`', 3)}{r @{tab}@{ifelse(is.null(opt), '', paste0(', ', opt))}}
@{code}
@{strrep('`', 3)}

@{desc}
")	

	if(!is.null(message)) {
		knitr_text = qq(
"@{strrep('`', 3)}{r, echo = FALSE, message = FALSE, fig.keep = 'none'}
message('@{message}')
@{strrep('`', 3)}

@{knitr_text}"
)
	}

	knitr_text = qq(
"
@{knitr_text}
")

	# while(dev.cur() > 1) dev.off()

	op2 = getOption("width")
	options(width = getOption("width"))
	md = knit(text = knitr_text, quiet = TRUE, envir = parent.frame())
	html = mark(text = md, options = c("-embed_resources", "-toc"))
	# add hide_and_show
	if(hide_and_show) {
		html = qq("
<div id='@{tab}'>
<p><a id='@{tab}-a' style='color:#0366d6' href='#'>show/hide code output</a></p>
@{html}
<script>
$('#@{tab}-a').parent().next().next().hide();
$('#@{tab}-a').click(function(){
  $('#@{tab}-a').parent().next().next().toggle();
  return(false);
});
</script>
</div>
")
	} else {
		html = qq("<div id='@{tab}'>\n@{html}\n</div>\n")
	}

	options(width = getOption("width"))
	KNITR_TAB_ENV$header = c(KNITR_TAB_ENV$header, header)
	KNITR_TAB_ENV$current_html = paste0(KNITR_TAB_ENV$current_html, html)
	return(invisible(NULL))
}

# TEMPLATE_DIR = system.file("extdata", package = "cola")
# TEMPLATE_DIR = "/desktop-home/guz/project/development/cola/inst/extdata"

# == title
# Generate the HTML fragment for the JavaScript tabs
#
# == param
# -uid A unique identifier for the div.
#
# == details
# The jQuery UI is used to generate html tabs (https://jqueryui.com/tabs/ ).
#
# `knitr_insert_tabs` should be used after several calls of `knitr_add_tab_item`
# to generate a complete HTML fragment for all tabs with all necessary Javascript and css code.
#
# This function is only for internal use.
#
# == value
# No value is returned.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
knitr_insert_tabs = function(uid) {

	if(!KNITR_TAB_ENV$css_added) {
		css = paste(readLines(file.path(TEMPLATE_DIR, "jquery-ui.css")), collapse = "\n")
		# remove comments
		css = gsub("\\/\\*.*?\\*\\/", '', css)
		cat("\n<style type='text/css'>\n")
		cat(css, "\n")
		cat("</style>\n")
		cat("<script src='js/jquery-1.12.4.js'></script>\n")
		cat("<script src='js/jquery-ui.js'></script>\n")
	}
	qqcat("
<script>
$( function() {
	$( '#tabs-@{uid}' ).tabs();
} );
</script>
")
	qqcat("<div id='tabs-@{uid}'>\n")
	cat("<ul>\n")
	qqcat("<li><a href='#tab-@{KNITR_TAB_ENV$prefix}-@{seq_len(KNITR_TAB_ENV$current_tab_index)}'>@{KNITR_TAB_ENV$header}</a></li>\n")
	cat("</ul>\n")
	cat(KNITR_TAB_ENV$current_html)
	cat("</div>\n")

	KNITR_TAB_ENV$current_tab_index = 0
	KNITR_TAB_ENV$header = NULL
	KNITR_TAB_ENV$current_html = ""
	KNITR_TAB_ENV$prefix = NULL
	KNITR_TAB_ENV$css_added = TRUE
	
	return(invisible(NULL))
}

# == title
# Make HTML report from the ConsensusPartitionList object
#
# == param
# -object A `ConsensusPartitionList-class` object.
# -output_dir The output directory where the report is saved.
# -mc.cores Multiple cores to use. This argument will be removed in future versions.
# -cores Number of cores, or a ``cluster`` object returned by `parallel::makeCluster`.
# -title Title of the report.
# -env Where the objects in the report are found, internally used.
#
# == details
# The `ConsensusPartitionList-class` object contains results for all combinations of top-value methods and partitioning methods.
# This function generates a HTML report which contains all plots and tables for every combination
# of method. 
#
# The report generation may take a while because it generates A LOT of heatmaps.
#
# Examples of reports can be found at https://jokergoo.github.io/cola_collection/ .
#
# == value
# No value is returned.
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
# == example
# if(FALSE) {
# # the following code is runnable
# data(golub_cola)
# cola_report(golub_cola[c("SD", "MAD"), c("hclust", "skmeans")], output_dir = "~/test_cola_cl_report")
# }
setMethod(f = "cola_report",
	signature = "ConsensusPartitionList",
	definition = function(object, output_dir = getwd(), mc.cores = 1, cores = mc.cores,
	title = "cola Report for Consensus Partitioning", env = parent.frame()) {

	check_pkg("genefilter", bioc = TRUE)
	var_name = deparse(substitute(object, env = env))
	make_report(var_name, object, output_dir, cores = cores, title = title, class = "ConsensusPartitionList")

})


# == title
# Make HTML report from the ConsensusPartition object
#
# == param
# -object A `ConsensusPartition-class` object.
# -output_dir The output directory where the report is saved.
# -title Title of the report.
# -env Where the objects in the report are found, internally used.
#
# == details
# It generates report for a specific combination of top-value method and partitioning method.
#
# == value
# No value is returned.
#
# == seealso
# `cola_report,ConsensusPartitionList-method`
#
# == author
# Zuguang Gu <z.gu@dkfz.de>
#
setMethod(f = "cola_report",
	signature = "ConsensusPartition",
	definition = function(object, output_dir = getwd(), 
	title = qq("cola Report for Consensus Partitioning (@{object@top_value_method}:@{object@partition_method})"), 
	env = parent.frame()) {

	check_pkg("genefilter", bioc = TRUE)
	var_name = deparse(substitute(object, env = env))
	make_report(var_name, object, output_dir, cores = 1, title = title, class = "ConsensusPartition")
})



make_report = function(var_name, object, output_dir, title = "cola Report for Consensus Partitioning", 
	cores = 1, class = class(object), ask = FALSE) {

	# if(identical(topenv(), .GlobalEnv)) {
	# 	stop_wrap("`cola_report()` cannot be run under test mode.")
	# }

	KNITR_TAB_ENV$prefix = NULL

	.t1 = Sys.time()
	template_file = c("HierarchicalPartition" = "cola_hc_template.Rmd-template",
		              "ConsensusPartitionList" = "cola_report_template.Rmd-template",
		              "ConsensusPartition" = "cola_single_report_template.Rmd-template")
	html_file = c("HierarchicalPartition" = "cola_hc.html",
		          "ConsensusPartitionList" = "cola_report.html",
		          "ConsensusPartition" = "cola_single.html")

	od = getOption("digits")
	wd = getwd()
	nv = length(dev.list())
	ohelp = cola_opt$help
	cola_opt$help = FALSE
	on.exit({
		options(digits = od)
		setwd(wd)
		if(!is.null(.ENV$TEMP_DIR)) {
			unlink(.ENV$TEMP_DIR, recursive = TRUE, force = TRUE)
			.ENV$TEMP_DIR = NULL
		}
		nv2 = length(dev.list())
		while(nv2 > nv & nv2 > 1) {
			dev.off2()
			nv2 = length(dev.list())
		}
		cola_opt$help = ohelp
	})

	options(digits = 3)

	# if(!multicore_supported()) {
	# 	if(cores > 1) qqcat("* `cores` is reset to 1 because multi-core is not supported on this OS.\n")
	# 	cores = 1
	# }
	TEMPLATE_DIR = TEMPLATE_DIR
	report_template = file.path(TEMPLATE_DIR, template_file[class])

	dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
	output_dir = normalizePath(output_dir, mustWork = FALSE)

	message(qq("* generating cola report for `@{var_name}` (a @{class} object)"))
	message(qq("* the report is available at @{output_dir}/@{html_file[class]}"))

	if(dir.exists(file.path(output_dir, "figure_cola"))) {
		fl = list.files(file.path(output_dir, "figure_cola"), pattern = "\\.png$", full.names = TRUE)
		if(length(fl)) {
			if(ask) {
				answer = readline("Found a 'figure_cola/' folder in the report folder, overwrite it? [y|n]?")
				if(tolower(answer) %in% c("y", "yes")) {
					
				} else {
					stop_wrap("Folder 'figure_cola/' cannot be deleted. Maybe you should choose another location for saving the report or delete it manually.")
				}
			}
			message(qq("* removing @{length(fl)} figures which were generated by previous report"))
			file.remove(fl)
		}
	}

	temp_dir = file.path(output_dir, "_cola_temp")
	if(file.exists(temp_dir)) {
		fl = list.files(temp_dir, full.names = TRUE)
		if(length(fl)) {
			message(qq("* removing @{length(fl)} figures in the temp dir."))
			file.remove(fl)
		}
	}
	dir.create(temp_dir, showWarnings = FALSE)
	.ENV$TEMP_DIR = temp_dir

	message("* generating R markdown file based on template report")
	rmd_file = file.path(output_dir, gsub("html$", "Rmd", html_file[class]))
	brew(report_template, output = rmd_file)
	md_file = gsub("Rmd$", "md", rmd_file)
	owd = getwd()
	setwd(output_dir)
	message("* rendering R markdown file to html by knitr")
	knit(rmd_file, md_file, quiet = TRUE)
	mark(md_file, output = file.path(output_dir, html_file[class]), options = c("-embed_resources", "-toc"))
	setwd(owd)

	dir.create(file.path(output_dir, "js"), showWarnings = FALSE)
	file.copy(file.path(TEMPLATE_DIR, "jquery-ui.js"), file.path(output_dir, "js"))
	file.copy(file.path(TEMPLATE_DIR, "jquery-1.12.4.js"), file.path(output_dir, "js"))
	file.copy(file.path(TEMPLATE_DIR, "jquery.tocify.js"), file.path(output_dir, "js"))
	file.copy(file.path(TEMPLATE_DIR, "favicon.ico"), output_dir)
	file.copy(file.path(TEMPLATE_DIR, "Ellipsis-4.2s-119px.gif"), output_dir)

	# message("* removing temporary files")
	# file.remove(c(rmd_file, md_file))

	message(qq("* report is at @{output_dir}/@{html_file[class]}"))

	## add favicon.ico line to the html file
	html_file = file.path(output_dir, html_file[class])
	lines = readLines(html_file)
	lines = c("<html>", "<head>", "<title>cola Report</title>", "</head>", "<body>", lines, "</body>", "</html>")

	## add name attribute to h2 and h3 tags
	l = grepl("^\\s*<h(2|3)>(.*?)</h(2|3)>\\s*$", lines)
	for(ind in which(l)) {
		foo = gsub("^\\s*<h(2|3)>(.*?)</h(2|3)>\\s*$", "\\2", lines[ind])
		foo = gsub("\\(p\\)", "", foo) # for e.g. node01(p)
		foo = gsub("\\W+$", "", foo)
		foo = gsub("\\W", "-", foo)
		lines[ind] = gsub("^\\s*<h(2|3)>(.*?)</h(2|3)>\\s*$", qq("<h\\1 id='@{foo}'>\\2</h\\3>"), lines[ind])
	}

	## add favicon
	ind = which(grepl("^<title>", lines[1:10]))
	lines[ind] = paste0('<link rel="ICON" type="image/x-icon" href="favicon.ico" />\n', lines[ind])
	
	### add loading flag
	ind = which(grepl("^<hr\\s*/>", lines[1:500]))[1]
	lines[ind] = paste0("<p id='loadingflag' style='text-align:center;'>Document is loading... <img src='Ellipsis-4.2s-119px.gif' style='vertical-align:middle;' /></p>\n", lines[ind])

	## add toc js at the end of the html
	nl = length(lines)
	ind = which(grepl("</body>", lines[(nl-10):nl])) + nl - 10 - 1
	lines[ind] = "
<script src='js/jquery.tocify.js'></script>
<div id='toc'></div>
<style>
.tocify {
  position: fixed;
  left: 10px;
  top: 10px;
  width: 200px;
  height: 100%;
  overflow:auto;
}
.tocify ul, .tocify li {
    list-style: none;
    margin: 0;
    padding: 1px 4px;
    border: none;
}
.tocify-subheader {
    text-indent: 10px;
}
.tocify-subheader .tocify-subheader {
    text-indent: 20px;
}
.tocify-subheader .tocify-subheader .tocify-subheader {
    text-indent: 20px;
}
.active {
    color: #ffffff;
    background-color: #0080FF;
}
.active a {
    color: #ffffff;
}
.tocify li:hover {
  background-color: #EFEFEF;
}
.tocify li:hover a  {
  color: #0366d6;
}
#toc {
	padding-bottom:20px;
}
</style>
<script>
$(window).on('load', function() {
  $('#toc').tocify({ 
    showAndHide: false,
    showAndHideOnScroll: false,
    selectors: 'h2,h3',
    showEffect: 'none',
    hashGenerator: 'pretty',
    highlightOnScroll: true
  }); 
  $('#toc li').first().addClass('tocify-item active');
  $('#loadingflag').hide();
  $('.frontmatter').hide()
});
</script>
</body>
"
	writeLines(lines, con = html_file)


	KNITR_TAB_ENV$current_tab_index = 0
	KNITR_TAB_ENV$current_div_index = 0
	KNITR_TAB_ENV$header = NULL
	KNITR_TAB_ENV$current_html = ""
	KNITR_TAB_ENV$random_str = round(runif(1, min = 1, max = 1e8))
	KNITR_TAB_ENV$css_added = FALSE

	.t2 = Sys.time()

	message(qq("* In total, the report generation uses @{gsub('^ +', '', format(.t2 - .t1))}."))

	return(invisible(NULL))
}


