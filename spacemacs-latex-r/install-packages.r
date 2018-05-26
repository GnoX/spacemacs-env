ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
}
packages <- c("ggplot2", "plyr", "reshape2", "scales", "grid", "plyr", "readxl",
              "FSA", "BSDA", "randtests", "aod", "ElemStatLearn", "car",
              "corrplot", "e1071")
ipak(packages)
