# get a list of files in the raw-data directory
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
df_list_selected <- lapply(df_list, function(df) {
  return(select(df, one_of(c("V7", "V6"))))
})

# for my file I need to normalise length into strain, since my strain signal is corrupted during sample loading
df_list_calculated <- lapply(df_list_selected, function(df) {
  df$strain <- ((df$V6 - df$V6[1])/df$V6[1]) * 100
  df <- df[, -which(names(df) == "V6")]
  return(df)
})

# write each data frame to a separate .txt file
for(i in seq_along(df_list_calculated)) {
  write.table(df_list_calculated[[i]], file = paste0("~/R/Biologic_tensile_properties/demo/input/", gsub(".dat", "", file_list[i]), "_cleaned.txt"), row.names= FALSE, sep=",")
}