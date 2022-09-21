#Read TXT file in input directory
read.table("Input/BC50GLU_01.txt", skip = 56, header = FALSE, sep = "", fileEncoding = "UTF-16")
df <- read.table("Input/BC50GLU_01.txt", skip = 56, header = FALSE, sep = "", fileEncoding = "UTF-16")

#Identify and name(optional) the signals you want to work with
df.length <- df$V6
df.stress <- df$V7

#Normalize strain signal based on length and add to the data frame
df$new <- ((df.length - df.length[1])/df.length[1])*100

#Build a new data frame with subset values of strain > 0.
df.sscurve <- df[df$new > 0,]

plot(df.sscurve$new, df.sscurve$V7)

#Referencia https://stackoverflow.com/questions/46108100/how-to-find-the-linear-part-of-a-curve 

