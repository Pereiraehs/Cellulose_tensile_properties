# get a list of files in the directory
file_list <- list.files("~/R/Biologic_tensile_properties/demo/raw-data/")

# create an empty list to store the data frames
df_list <- list()

# loop over the files and read them into separate data frames
for(i in seq_along(file_list)){
  df_list[[i]] <- read.table(file = paste0("~/R/Biologic_tensile_properties/demo/raw-data/", file_list[i]),
                             skip = 56, header = FALSE, sep = "", fileEncoding = "UTF-16")
}

# load the dplyr library
library(dplyr)

# extract the stress and strain signls from each data frame
# for my file I need to normalise length into strain, since my strain signal is corrupted during sample loading
df_list_selected <- lapply(df_list, function(df) {
  return(select(df, one_of(c("V6", "V5"))))
})