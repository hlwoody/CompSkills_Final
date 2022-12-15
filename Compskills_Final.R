####################################
#####                          #####
#####      FINAL PROJECT       #####
#####                          #####
####################################

#WRITTEN BY: Hannah Woody
#WRITTEN ON: 12/6/2022
#LAST UPDATED: 12/15/2022

## Define Dataset/ Create Dataframe
titanic <- as.data.frame(Titanic)

## Install tidyverse package, for ease of filtering
library("tidyverse")

#############################
##                         ##
##   COMPARE SURVIVORSHIP  ##
##     FOR EACH CLASS OF   ##
##        PASSENGER        ##
##                         ##
#############################


## Filter sub-set dataframe to just those that have survived the titanic and group then sum totals of each class 
sex_class_survived <- titanic %>% 
  filter(Survived == "Yes") %>% #filter to only those that survived
  select (Class, Sex, Freq) %>% #keep class, sex, and frequency
  group_by(Class, Sex) %>% #group by class and then sex
  summarize(Totalclasssex=sum(Freq)) #sum the total frequency for each class and gender

## Get totals of each sex present in the different classes for plotting comparison
sex_class_total <- titanic %>% 
  select (Class, Sex, Freq) %>% #keep class, sex, and frequency
  group_by(Class, Sex) %>% #group by class and then sex
  summarize(completeclasssex=sum(Freq)) #sum the total frequency for each class and gender

percent_survival <- (sex_class_survived$Totalclasssex/sex_class_total$completeclasssex)*100
percent_survival <- round(percent_survival, digits=0)

## Turn filtered and grouped data into a dataframe for easy plotting in base R
classcomp <- data.frame(sex_class_survived$Class, sex_class_survived$Sex, sex_class_survived$Totalclasssex, sex_class_total$completeclasssex, percent_survival )
colnames(classcomp) <- c("Class", "Sex", "Survived", "Total", "Survived_Percent") #Rename column names so they are easier to work with in plotting

## Create a bar plot displaying survivorship between sexes in each of the classes
ggplot(data=classcomp, aes(fill = Sex)) + #Fills bars with different colors defined by gender
  geom_col(aes(x=classcomp$Class, y=classcomp$Survived), position = position_dodge2(width = 0.5)) + #position dodge makes sure that male/female bars do not overlay eachother but are seperated by 0.5
  geom_col(aes(x=classcomp$Class, y=classcomp$Total),alpha = 0.4, position= position_dodge2(width =0.5))+
  scale_fill_manual(name = "Gender", values = c("cornflowerblue", "pink")) + #Defines colors for the fill=Sex
  geom_text(aes(x=classcomp$Class, y=classcomp$Survived, label=paste(classcomp$Survived_Percent, "%")), size=3.5, vjust= 0, position= position_dodge2(width =0.8))+
  ggtitle("Percent of survivorship between class and Gender")+
  ylab("Number of Passengers")+
  xlab("Class of Passengers")
  

#############################
##                         ##
##   COMPARE SURVIVORSHIP  ##
##    BETWEEN GENDERS OF   ##
##        PASSENGERS       ##
##                         ##
#############################


## Filter sub-set dataframe to just those that have survived the titanic and group by sex, sum total of each sex
sex_survived <- titanic %>% 
  filter(Survived == "Yes") %>% #filter to only those that survived
  select (Sex, Freq) %>% #keep sexes and frequency of each sex
  group_by(Sex) %>% #group by the sex
  summarize(Totalsex=sum(Freq)) #sums the total of survival between each sex


## Group by sex, and create sums of each sex present on titanic, regardless of whether they survived or not
sex_totals <- titanic %>% 
  select (Sex, Freq) %>% #keep sexes and frequency of each sex
  group_by(Sex) %>% #group by the sex
  summarize(Totalsexes=sum(Freq))#sums total frequency of each sex on the titanic regardless of surival

## Calculate percentages of survival so that it can be plotted below
perc_survival <- (sex_survived$Totalsex/sex_totals$Totalsexes)*100 #Calculates %
perc_survival <- round(perc_survival, digits=0) #Rounds to the nearest whole number, 0 decimal places

## Turn filtered and grouped data into a dataframe for easy plotting in base R
sexcomp <- data.frame(sex_totals$Totalsexes, sex_survived$Totalsex, sex_totals$Sex, perc_survival)
colnames(sexcomp) <- c("Totals", "Survivors", "Genders", "Percent_of_Survival") #Rename column names so they are easier to work with in plotting


## Create a bar plot displaying survivorship between sexes
## For this bar plot, bars are "stacked", this was done by defining two Y values in geom_bar and setting the
## alphas to lower values so that survived/green could be seen over notsurvived/red
 ggplot(data=sexcomp, aes(x=Genders)) +
  geom_bar(aes(y= Totals), stat="identity", position ="identity" , alpha=.3, fill='red') + 
  geom_bar(aes(y= Survivors), stat="identity", position="identity", alpha=.4, fill='green') +
   scale_fill_manual(name = "Survival", values = c("red", "green")) + #Holding attempt at making legend...
   geom_text(aes(x=Genders, y= Survivors, label=paste(sexcomp$Percent_of_Survival, "%")), size=3.5, vjust= 0, position= position_dodge2(width =0.8))+ #Adds percentages to top of survived bar
   ggtitle("Percent of survivorship between sexes")+
   ylab("Number of Passengers")+
   xlab("Gender of Passengers")
 


        