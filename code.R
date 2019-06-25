
#Install necessary packages
setRepositories()
install.packages("read.dbc")
install.packages("plyr")
install.packages("RCurl")
library(read.dbc)
library(foreign)
library(plyr)

#Clean workdirectory and set workdirectory
rm(list=ls())
setwd("D:/Paper_CS/Dados_Brutos")




#Start code to download SINASC DATABASE FROM 2015 to 2017. It saves it in dta. files
prefix = "DN"
year = list( "2015", "2016", "2017" )
st = list("RO", "AC", "AM", "RR", "PA", "AP", "TO", "MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA", "MG", "ES", "RJ", "SP", "PR", "SC", "RS", "MS", "MT", "GO", "DF")

url1 <- "ftp://ftp.datasus.gov.br/dissemin/publicos/SINASC/NOV/DNRES/"

for(y in 1:length(year)){
  for(s in 1:length(st)){
    url <- paste0(url1,prefix,st[s],year[y],".dbc")
    download.file(url, destfile = paste0(prefix,st[s],year[y],".dbc"), mode = "wb")
    dn <- read.dbc(paste0(prefix,st[s],year[y],".dbc"))
    save(dn, file=paste0(prefix,st[s],year[y],".rdata"))
    write.dta(dn,file=paste0(prefix,st[s],year[y],".dta"), convert.factors = "string", convert.dates = FALSE)
    rm(dn)
    
  }
}


