#!/usr/bin/env r
#
# A second example to install one or more packages, now with option parsing
#
# Copyright (C) 2011 - 2014  Dirk Eddelbuettel
# Copyright (C) 2014         Carl Boettiger and Dirk Eddelbuettel
#
# Released under GPL (>= 2)

suppressMessages(library(docopt))       # we need docopt (>= 0.3) as on CRAN

doc <- "Usage: install.r [-h] [--error] [PACKAGES ...]

-e --error          Throw error and halt instead of a warning [default: FALSE]
-h --help           show this help text"

opt <- docopt(doc)

if (opt$error) {
    withCallingHandlers({
                        library(utils)
                        source("http://bioconductor.org/biocLite.R")
                        biocLite(opt$PACKAGES)},
        warning = stop)
} else {
	library("utils")
	source("http://bioconductor.org/biocLite.R")
	biocLite(opt$PACKAGES)
}
