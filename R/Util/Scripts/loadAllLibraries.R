#!/usr/bin/env Rscript

# Description:
# Installs (if necessary) and loads all library dependencies

# IMPORTANT NOTE:
# Make sure all system requirements are installed on your system or else
# package installation will fail. Check the packages website for system
# requirements

# Install Library packages if necessary
if (!exists("loadAllLibraries.guard")){
  loadAllLibraries.guard <- "INSTALLED"		# Defines loadAllLibraries.guard variable
  mirror <- "http://cran.ma.imperial.ac.uk/"
  install.packages(c("tools", "quantmod", "tseries", "vars", "fxregime", "forecast", "XML", "RMySQL"), repos = mirror)
}

# Load all Library packages
  library("tools") 
  library("quantmod")
  library("tseries") 
  library("vars")
  library("fxregime")
  library("forecast")
  library("XML")
  library("RMySQL")
