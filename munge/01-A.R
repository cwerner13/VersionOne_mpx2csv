### mpx-File looks like csv
### - Load file from subdirectory, 
### - drop rows that are not needed  # skip 15 rows, 
### - keep character values (don't turn them into factors)
vOne <- read.csv("./data/export.mpx", sep=",",header=F, skip=15, stringsAsFactors=FALSE)

### - Rename colum 1-24
nn<-names(vOne)
nn[1:25] <- c("rowtype", "storytitle","C", "estimate", "actual","F","date1","H","date2","date3","K","ID","M","N","O","P","Q","R","task_estimate","task_actual","U","level","W","X","Y")
names(vOne) <- nn

### - convert Dates
vOne$date1<-as.Date(substr(vOne$date1,0,10), "%Y-%m-%d") 
vOne$date2<-as.Date(substr(vOne$date2,0,10), "%Y-%m-%d") # date entered
vOne$date3<-as.Date(substr(vOne$date3,0,10), "%Y-%m-%d") 

### - drop columns that are not neede
drop_columns <- c("K","M", "N","O","P", "Q")
vOne= vOne[,!(names(vOne) %in% drop_columns)]

### - drop more rows that are not needed  # keep the detail rows (task,descr)
vOne = vOne[(vOne$rowtype==70) | (vOne$rowtype==71),]
