# loads the source code for the function named function_name under the assumption the path to the function source code is R/functions/function_name.R and we're in a UNIX environment

loadFunction <- function(function_name, rel_path){
	# function_name		- the name of the function to load
	# rel_path		- the relative path of the "functions" directory from the current working directory (ending with forwardslash)

	if(!exists(function_name, mode="function")){
		file_name <- paste(rel_path, function_name, ".R", sep="")
		source(file_name)
	}
}
