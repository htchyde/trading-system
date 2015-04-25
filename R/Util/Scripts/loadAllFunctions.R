#!/usr/bin/env Rscript

# Description:
# Script that loads the source code of all functions located in R 

# Load all Library Dependencies
source("./loadAllLibraries.R")

# load the code for the "loadFunction" function
if(!exists("loadFunction", mode="function"))
	source("../functions/loadFunction.R")

# get the list of all functions
list_of_functions <- list.files(path = "../functions", full.names = "TRUE")

# load each of the function files
for(file_fullpath in list_of_functions){
#	file_basename <- sub("(.*/)([^.]*)(.*)", "\\2", file_fullpath)
	file_basename <- file_path_sans_ext(basename(file_fullpath))
	loadFunction(file_basename, "../functions/")
}
