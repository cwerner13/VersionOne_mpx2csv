library('ProjectTemplate')
load.project()

### Select the rows you want to export
data = data[data$Sprint>=as.character("Sprint 2013-01"),]
### Select the colums you want to export

# Attention: Text contains "" (quotes), therefore qmethod = "double" instead of "escape"
write.table(x = data, file = "reports/versionOne.csv", sep = ",", qmethod = "double",row.names = FALSE, col.names = TRUE)


### graph
category <-as.factor(data$Story)
category <-as.factor(substr(data$Story_Descr,0,30))

par(mfrow=c(1,2))
plot(data$date2,category,col=category,cex=(data$task_estimate/8.5),yaxt="n", ylab="",xlab="Training Data obs.", pch=19, cex.axis=0.7)
plot(data$date2,category,col=category,cex=(data$task_actual/8.5),yaxt="n", ylab="",xlab="Training Data obs.", pch=19, cex.axis=0.7)
axis(side=2,at=unique(category),labels=unique(category), cex.axis=0.7, las=2)