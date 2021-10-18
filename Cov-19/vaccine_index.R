all_index<-read.csv('owid-covid-data.csv')
head(all_index)
library(data.table)
all_dt<-data.table(all_index)
all_dt$date<-as.Date(all_dt$date)


#fill na with previous day's value
fillna<-function(mylist){
  previous = 0
  for(i in 1:length(mylist)){
    if(is.na(mylist[i])){
      mylist[i]=previous
    }
    else{
      previous=mylist[i]
    }
  }
  return(mylist)
}

sg_dt<-all_dt[iso_code=='SGP']
sg_dt$total_vaccinations<-fillna(sg_dt$total_vaccinations)#total vaccination times (multiple count for one person)
sg_dt$total_vaccinations_per_hundred<-fillna(sg_dt$total_vaccinations_per_hundred)
sg_dt$people_fully_vaccinated_per_hundred<-fillna(sg_dt$people_fully_vaccinated_per_hundred)#fully vaccinated rate

uk_dt<-all_dt[iso_code=='GBR']
uk_dt$people_fully_vaccinated_per_hundred<-fillna(uk_dt$people_fully_vaccinated_per_hundred)
plot(ts(uk_dt$total_cases))

start_date<-'2020-04-01'
end_date<-'2021-09-30'

sg_dt_train<-sg_dt[date>=as.Date(start_date)][date<=as.Date(end_date)]
uk_dt_train<-uk_dt[date>=as.Date(start_date)][date<=as.Date(end_date)]


