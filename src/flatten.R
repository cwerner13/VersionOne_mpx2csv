library('ProjectTemplate')
load.project()

### Flag Levels in Hierarchy

### Lowest Level = Task/4
### Enrich records with Higher Level information (keep higher level in mind)
Flag_Epic    <- vOne$rowtype==70 & vOne$level==1  
Flag_Sprint  <- vOne$rowtype==70 & vOne$level==2
Flag_Story   <- vOne$rowtype==70 & vOne$level==3
Flag_Task    <- vOne$rowtype==70 & vOne$level==4
Flag_Detail  <- vOne$rowtype==71

result <- data.frame(ID      = character(0),
                     Epic    = character(0),
                     Sprint  = character(0),
                     Story   = character(0),
                     Story_Descr  = character(0),
                     Task    = character(0),
                     Descr   = character(0),
                     Detail  = character(0), stringsAsFactors = FALSE)

Temp_Epic    = character(0)
Temp_Sprint   = character(0)
Temp_Story   = character(0)
Temp_Story_Descr  = character(0)
Temp_Task    = character(0)
Temp_Descr   = character(0)
Temp_Detail  = character(0)

Temp_Epic    <- "empty"
Temp_Sprint  <- "empty"
Temp_Story   <- "empty"
Temp_Story_Descr  <- "empty"
Temp_Task    <- "empty"
Temp_Descr   <- "empty"
Temp_Detail  <- "empty"

for (i in 1:nrow(vOne))
{  if (Flag_Epic[i])
{Temp_Epic    <- as.character(substr(vOne$storytitle[i], 0, 80))
 Temp_Story   <- "empty"
 Temp_Story_Descr  <- "empty"
 Temp_Task    <- "empty"
 Temp_Descr   <- "empty"
} else {
  if (Flag_Sprint[i])
  {Temp_Sprint  <- as.character(substr(vOne$storytitle[i], 0, 80))
   Temp_Story   <- "empty"
   Temp_Story_Descr  <- "empty"
   Temp_Task    <- "empty"
   Temp_Descr   <- "empty"
  } else {
    if (Flag_Story[i])
    {Temp_Story <- (vOne$ID[i])
     Temp_Story_Descr  <- as.character(substr(vOne$storytitle[i], 0, 80))
     Temp_Task    <- "empty"
     Temp_Descr   <- "empty"
    } else { if (Flag_Task[i])
    {Temp_Task  <-  (vOne$ID[i])
     Temp_Descr <- as.character(substr(vOne$storytitle[i], 0, 80))
    } else {  }
    }
  }}
   
### in case row contentis a detailled description, it belongs to the previous row 
   if(Flag_Detail[i])
   { result$Detail[i-1] <- vOne$storytitle[i]    
   } else {
     Temp_Detail <- "empty"
     result[i, ] <- cbind(vOne$ID[i],Temp_Epic,Temp_Sprint, Temp_Story, Temp_Story_Descr, Temp_Task,Temp_Descr,Temp_Detail)
   }}

### the results are added as new columns to the original vOne (Key = "Task")
data <- data.frame <- merge(vOne, result, by.x = "ID", by.y = "Task")