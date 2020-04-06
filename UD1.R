
# Actividade 1 UD1 
# Actividad de tratamiento de datos com e carca de R


# Parte A
library(dplyr)
# 1- Criar un dataframe apartir del vectores

x<- c(1,2,3,1,4,5,2)
y<-c(0,3,2,0,5,9,3)

dt= data.frame(x,y)
dt

#2- Elimina los duplicados usando una función de R adecuada help(unique)

help(unique)

dt.uniq<- unique(dt)
dt.uniq

#3- Pon nombre a las filas con nombres “CA”,“SE”,“MA”,“BA”,“VA”

rownames(dt.uniq)<- c('CA','SE','MA','BA','VA')
dt.uniq

#4 - Crea una nueva columna Z que sea la suma de las dos primeras dividida por la primera


mutate(dt.uniq, z = (dt.uniq$x+dt.uniq$y)/dt.uniq$x) #transformamos una columna
dt1.uniq<-dt.uniq
#ou
dt1.uniq$w <- (dt1.uniq$x+dt1.uniq$y)/dt1.uniq$x
dt1.uniq

#5- Cambia el valor X de la provincia BA por 2

dt.uniq[4,1:1]<- 2

dt.uniq

#6- Selecciona aquellas provincias cuyo valor Y sea menor que 4

filter(dt.uniq, y <=4)
#ou
dt.uniq[dt.uniq$y<=4,]
#ou
subset(dt.uniq,subset=c(y<=4))

# Parte 2
getwd()
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data"
 
dat <- read.csv(url,na.strings = "?", header=FALSE)
View(dat)

# 1- Haz un sumario del dataframe.
summary(dat)

# 2- ¿Qué dimensión tiene el dataframe?
dim(dat)

#3- Inspecciona los datos, ¿de qué clase es cada tipo? Extrae los distintos valores que toman los factores

lapply(dat,class)
class(dat)
str(dat)

factores<- which(sapply(dat,class)=="factor")
factores
for (i in 1:length(factores)){
  print(unique(dat[,i]))
}


#4- Indica la proporción de valores faltantes por columna usando sum e is.na y un apply (usa nrow).
# 

apply(is.na(dat),2,sum)/nrow(dat)*100

#5- Edita la primera columna llevándola al rango 0-5.
dat$V1 <- dat$V1+3
dat$V1

#6- Da una media de los valores de la primera columna respecto a la columna de número de puertas del coche.

tapply(dat$V1, dat$V6, mean)

#7- Extrae los coches audi que son cuatro puertas con valor V13 menor que 55

dtf<-filter(dat,V3=='audi'& V6=="four" & V13 < 55)

View(dtf)

# Ou

dat[dat$V3=='audi' & dat$V6=='four'& dat$V13< 55,]