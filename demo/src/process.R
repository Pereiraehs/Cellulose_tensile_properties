#Read TXT/CSV file in input directory with stress and strain sgnals
cfile_list <- list.files("~/R/Biologic_tensile_properties/demo/input/")

# create an empty list to store the data frames
cdf_list <- list()

# loop over the files and read them into separate data frames
for(i in seq_along(cfile_list)){
  cdf_list[[i]] <- read.table(file = paste0("~/R/Biologic_tensile_properties/demo/input/", cfile_list[i]),
                             header = TRUE, sep=",")
}

library(ggplot2)
library(cowplot)

# Create an empty list to store the plots
plots_list <- list()

# Loop over the datasets
for (i in seq_along(cdf_list)) {
  # Filter out negative values
  cdf_list[[i]] <- cdf_list[[i]][cdf_list[[i]]$"strain" >= 0,]
  
  # Create a plot using ggplot2
  p <- ggplot(cdf_list[[i]], aes(x = strain, y = V7)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = FALSE, color = "blue") + 
    scale_x_continuous(limits = c(min(cdf_list[[i]]$"strain"), max(cdf_list[[i]]$"strain"))) + 
    scale_y_continuous(limits = c(0, max(cdf_list[[i]]$"V7")))
  
  # Store the plot in the list
  plots_list[[i]] <- p
}

# Plot the list of plots using cowplot
plot_grid(plotlist = plots_list, ncol = 2)

#Finding the curve linear portion
a <- data.frame(x = df.sscurve$new,
                y = df.sscurve$V7)

  b <- diff(a[,2])/diff(a[,1])
  b.k <- kmeans(b,3)
  b.max <- max(abs(b.k$centers))
  b.v <- which(b.k$cluster == match(b.max, b.k$centers))

  RES <- a[b.v,]
  plot(a)
  points(RES,pch=15, col="red")
  abline(coef(lm(y~x,RES)), col="blue")

#[1] Reference akond (https://stackoverflow.com/questions/46108100/how-to-find-the-linear-part-of-a-curve)
  
#Young's module identification 

coef(lm(y~x,RES))

# X is related to the Young's modulus
