
install.packages('lubridate')
library(dplyr)
library(ggplot2)
library(lubridate)
dtemp<- read.csv('global_emperatures.csv')

View(dtemp)

dim(dtemp)
str(dtemp)

# Verificar NA
colSums(is.na(dtemp))

# imputing missiing values
for (i in 1:ncol(dtemp)){
  if (sum(is.na(dtemp[,i]) > 0)){
    c1<- which(is.na(dtemp[,i]) ) 
    dtemp[c1,i]<- round(mean(is.na(dtemp[,i])),3)
  }
}


str(dtemp)

summary(dtemp)

#Representamos temperaturas médias por mês desde 1850. Pode-se ver claramente que, embora a temperatura da terra permaneça em uma elevação suave, a da terra e do oceano tem uma subida mais acentuada ao longo do tempo.

dtemp$dt <- as.Date(dtemp$dt,"%Y-%m-%d")
dtemp$Year<-year(dtemp$dt)
dtemp$Month<- as.numeric(format(dtemp$dt,"%m"))
dtemp$Month<- format(dtemp$dt,"%B")
View(dtemp)


#temperaturas médias por mês de la terra desde 1850
dt<- dtemp%>% select(!(dt))%>%
              filter(Year >=1850)
View(dt)

ggplot(dt,aes(x=Year,y=LandAverageTemperature, colour=reorder(Month,-LandAverageTemperature,mean)))+
  geom_point()+
  geom_smooth(method="loess")+
  labs(title="Temperatura media de la tierra por mes",
       x="Año",
       y="Temperatura media de la tierra",
       colour="Mes")


#temperaturas médias por mês de la Oceáno desde 1850
ggplot(dt,aes(x=Year,y=LandAndOceanAverageTemperature, colour=reorder(Month,-LandAverageTemperature,mean)))+
  geom_point()+
  geom_smooth(method="loess")+
  labs(title="Temperatura media de la tierra y oceáno por mes",
       x="Año",
       y="Temperatura media de la tierra y oceáno ",
       colour="Mes")

#Ou
ggplot(dt,aes(Year))+
  geom_line(aes(y = LandAverageTemperature, colour = "LandAveregeTerra"),size=1)+
  geom_line(aes(y = LandAndOceanAverageTemperature, colour = "LandAveregeTerraOcenao"),size=1)



dtemp$MaxMinLandDifference  <- dtemp$LandMaxTemperature - dtemp$LandMinTemperature
dtemp$Quarter <- quarters(dtemp$dt)


#gráfica de las máximas por año
  dtemp%>% 
  filter(Year>1850)%>%
  group_by(Year) %>% 
  summarise(MaxTemp = mean(LandMaxTemperature)) -> MaxByYear
  
  
 qplot(Year, MaxTemp, data=MaxByYear, main="Máxima en tierra por año desde 1850",geom=c("point","smooth"))+ aes(colour = MaxTemp) + scale_color_gradient(low="blue", high="red")
  

ggplot(data=MaxByYear,aes(Year,MaxTemp, colour=MaxTemp))+
  geom_point()+
  geom_line()+
  geom_smooth(method="loess")+
  labs(title="Temperatura Máxima en tierra por año desde 1850",
       x="Año",
       y="Temperatura Máximade la tierra",
       colour="MaxTemperatura")+
  scale_color_gradient(low="blue", high="red")+
  theme(axis.text.x = element_text(angle = 90, size = 10, vjust = 0.4))

  

#gráfica de las minima por año
dtemp%>% 
  filter(Year>1850)%>%
  group_by(Year)%>% 
  summarise(MinTemp = mean(LandMinTemperature)) -> MinByYear


qplot(Year, MinTemp, data=MinByYear, main=" Temperatura Mínima  en tierra por año desde 1850",geom=c("point","smooth"))+ aes(colour = MinTemp) + scale_color_gradient(low="blue", high="red")

ggplot(data=MinByYear, aes(Year, MinTemp,colour=MinTemp))+
geom_point()+
geom_line()+
geom_smooth(method="loess")+
labs(title="Temperatura Máxima en tierra por año desde 1850",
x="Año",
y="Temperatura Máximade la tierra",
colour="MaxTemperatura")+
scale_color_gradient(low="blue", high="red")+
theme(axis.text.x = element_text(angle = 90, size = 10, vjust = 0.4))


# Diferença entre temperatura máxima e mínima
dtemp%>% select(Quarter,Year,MaxMinLandDifference)%>%
  filter(Year>1850)%>%
  group_by(Year,Quarter)%>% 
  summarise(MinMaxTemp = mean(MaxMinLandDifference)) -> MaxMinDiff


ggplot(data=MaxMinDiff,aes(Year,MinMaxTemp))+
geom_point()+
geom_line()+
geom_smooth(method="loess")+
labs(title="Diferença entre temperatura máxima e mínima desde 1850",
x="Año",
y="Diferença da temperatura")+
scale_color_gradient(low="blue", high="red")+
theme(axis.text.x = element_text(angle = 90, size = 10, vjust = 0.4))

#gráfica con la evolución cuatrimestral

ggplot(data=MaxMinDiff,aes(Year,MinMaxTemp,fill=Quarter))+
  geom_point()+
  geom_smooth(method="loess")+
  labs(title="Diferença entre temperatura máxima e mínima por cuartemestre desde 1850",
  x="Año",
  y="Diferença da temperatura",
  fill="Quarter")+
  scale_color_gradient(low="blue", high="red")+
  theme(axis.text.x = element_text(angle = 90, size = 10, vjust = 0.4))



#Vemos a distribuição das temperaturas da terra e do oceano ao longo do ano. Quase todos os meses, eles têm as mesmas anomalias ou valores extremos.


dtemp%>%
  #filter(Year>=1850)%>%
  group_by(Month)%>%
  summarise(media=mean(LandAndOceanAverageTemperature)) -> MediaMesTemp

 MediaMesTemp$Month<- as.factor(MediaMesTemp$Month)
 str(MediaMesTemp)
 
 ggplot(MediaMesTemp, aes(Month , media))+
 geom_boxplot(fill="blue1")
 
 
 #Temperaturas médias de acordo com o mês nos anos indicados
 
 df_sel<- dtemp%>%
             filter(Year %in% c(1850,1900,1950,1975,1995,2004))
 
 ggplot(data=df_sel,aes(Month,LandAndOceanAverageTemperature, colour=as.factor(Year)))+
   geom_line()+
   geom_point()+
   #geom_smooth(method="loess")
   geom_smooth(se=FALSE,fill=NA, size=2) +
   theme_light(base_size=14)
   

          

 str(df_sel)

 