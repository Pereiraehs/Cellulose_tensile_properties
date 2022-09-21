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

a <- data.frame(x=c(0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360), 
                y=c(2.175, 2.134, 2.189, 2.141, 2.854, 3.331, 3.642, 4.333, 4.987, 5.093, 4.943, 5.198, 4.804))

b <- diff(a[,2])/diff(a[,1])
b.k <- kmeans(b,3)
b.max <- max(abs(b.k$centers))
b.v <- which(b.k$cluster == match(b.max, b.k$centers))

RES <- a[b.v,]
plot(a)
points(RES,pch=15)
abline(coef(lm(y~x,RES)), col="red")



