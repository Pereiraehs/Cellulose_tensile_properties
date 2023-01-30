#Read TXT/CSV file in input directory
#Make for to know what king of file encoding your equipment software will provide
df <- read.table("Input/BC50TAw_01.txt", skip = 56, header = FALSE, sep = "", fileEncoding = "UTF-16")

#Identify and name(optional) the signals you want to work with
df.length <- df$V6
df.stress <- df$V7

#Normalize strain signal based on length and add to the data frame
df$new <- ((df.length - df.length[1])/df.length[1])*100

#Build a new data frame with subset values of strain > 0.
df.sscurve <- df[df$new > 0,]

#Test and see if your Strain x Stress curve is correct
plot(df.sscurve$new, df.sscurve$V7) 

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
