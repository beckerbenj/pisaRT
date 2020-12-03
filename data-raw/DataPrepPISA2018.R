
# download "Cognitive items total time/visits data file" from https://www.oecd.org/pisa/data/2018database/
memory.limit(size=80000)
library(haven)

# Read PISA responses; subset Canada and Math
PISA<-read_sav("CY07_MSU_STU_COG.SAV")

PISACan<-PISA[PISA$CNT=="CAN",]
PISACanM<-PISACan[,c(grep("CNT", colnames(PISACan)),grep("M[0-9]", colnames(PISACan)))]

# Read PISA RTs; subset Canada and Math
PISATT<-read_sav("CY07_MSU_STU_TTM.SAV")
PISATTCan<-PISATT[PISATT$CNT=="CAN",]
PISATTCanM<-PISATTCan[,c(grep("CNT", colnames(PISATTCan)),grep("M[0-9]", colnames(PISATTCan)))]

# merge
RespRT<-merge(PISACanM,PISATTCanM, by.x="CNTSTUID", by.y="CNTSTUID")
RespRT <-RespRT[, grep("C$|S$|TT$", colnames(RespRT))]  # only coded resp and response times
RespRT<- RespRT[, -grep("^P|RC$", colnames(RespRT))]
names(RespRT)

# responses and RTs
resp<-RespRT[, grep("C$|S$", colnames(RespRT))]
resptimes<-RespRT[, grep("TT$", colnames(RespRT))]

# booklets for every item, see technical report
booklet<-c()
booklet[1:which(names(resptimes)=="CM034Q01TT")]<-1
booklet[which(names(resptimes)=="CM305Q01TT"):which(names(resptimes)=="CM564Q02TT")]<-2
booklet[which(names(resptimes)=="CM447Q01TT"):which(names(resptimes)=="CM800Q01TT")]<-3
booklet[which(names(resptimes)=="CM982Q01TT"):which(names(resptimes)== "CM00KQ02TT")]<-4

booklet[which(names(resptimes)=="CM909Q01TT"):which(names(resptimes)=="CM998Q04TT")]<-5
booklet[which(names(resptimes)=="CM905Q01TT"):which(names(resptimes)=="CM953Q04TT")]<-6
booklet[which(names(resptimes)=="CM948Q01TT"):which(names(resptimes)=="CM967Q03TT")]<-7

# subset first booklet
respM1<-resp[,booklet==1]
resptimesM1<-resptimes[,booklet==1]


# remove examinees with no observed responses
summis<-apply(resptimesM1, 1, function(x) sum(is.na(x)))
respM1<-respM1[summis!=ncol(respM1),]
resptimesM1<-resptimesM1[summis!=ncol(resptimesM1),]/1000

# recode partial credit
PCM<-grep("C$", names(respM1))
for(i in PCM){
  if(max(respM1[,i], na.rm=T)>10){
    respM1[, i] <- respM1[, i]%/%10
  }
}


save(respM1,resptimesM1, file = "data-raw/PISACan2018M1.RData")







