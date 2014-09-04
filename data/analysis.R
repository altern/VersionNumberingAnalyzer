source('util.R')

printTestResults <- function(v1, v2, name1, name2) {
  print(paste0("        ", name1, " average: ", mean(v1)))
  print(paste0("        ", name2, " average: ", mean(v2)))
  pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
  if (pvalue < 0.05) {
    print(paste0("    !!! wilcox p-value = ", pvalue, " !!!"))
  } else {
    print(paste0("    wilcox p-value = ", pvalue))
  }
  return(pvalue)
#   pvalue <- chisq.test(v1, v2)$p.value
#   print(paste0("    chisq p-value = ", pvalue))
}

analyzeColumnDependencies <- function(colName1, colName2) {
  prunnedData <- removeZeroes(data, colName1)
  prunnedData <- removeOutliers(prunnedData, colName1)
  prunnedData <- removeZeroes(prunnedData, colName2)
  prunnedData <- removeOutliers(prunnedData, colName2)
  v1 <- as.numeric(prunnedData[[colName1]])
  v2 <- as.numeric(prunnedData[[colName2]])
  print(paste0("   Average ", colName1, ": ", mean(v1) ) )
  print(paste0("   Average ", colName2, ": ", mean(v2) ) )
  pvalue = wilcox.test(v1, v2, paired=TRUE, exact=FALSE)$p.value
  print(paste0("      pvalue = ", pvalue))
  frame <- data.frame(
    gsub("_", " ", paste0(colName1, " vs ",colName2)), 
    round(mean(v1), 4), 
    round(mean(v2), 4), 
    round(pvalue, 4)
  )
  names(frame) <- c("metricName", "average1", "average2", "pvalue")
  return(frame)
}
calculateMetric <- function ( metricName, colName, d1, d2, name1, name2, values ) {
  list(metricNames, averages1, averages2, pvalues) <- values
  print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1[[colName]])
  v2 <- as.numeric(d2[[colName]])
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    pvalues <- c(pvalues, pvalue)
  }
  return (list(metricNames, averages1, averages2, pvalues))
}
calculateAggregatedMetrics <- function(d1, d2, name1, name2) {
  print("Size of samples:")
  print(paste0("    ", name1, ": ", nrow(d1)))
  print(paste0("    ", name2, ": ", nrow(d2)))
  print("")

  metricNames <- c()
  averages1 <- c()
  averages2 <- c()
  names1 <- c()
  names2 <- c()
  pvalues <- c()
  
  print("== 2nd version compound metrics == ")
  metricName <- "2nd version compound sum of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X2nd_vc_sum_of_jumps)
  v2 <- as.numeric(d2$X2nd_vc_sum_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "2nd version compound avg of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X2nd_vc_avg_of_jumps)
  v2 <- as.numeric(d2$X2nd_vc_avg_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  metricName <- "2nd version compound number of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X2nd_vc_number_of_empty_jumps)
  v2 <- as.numeric(d2$X2nd_vc_number_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "2nd version compound sum of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X2nd_vc_sum_of_empty_jumps)
  v2 <- as.numeric(d2$X2nd_vc_sum_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "2nd version compound avg of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X2nd_vc_avg_of_empty_jumps)
  v2 <- as.numeric(d2$X2nd_vc_avg_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  print("== 3rd version compound metrics == ")
  metricName <- "3rd version compound sum of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X3rd_vc_sum_of_jumps)
  v2 <- as.numeric(d2$X3rd_vc_sum_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "3rd version compound avg of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X3rd_vc_avg_of_jumps)
  v2 <- as.numeric(d2$X3rd_vc_avg_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  metricName <- "3rd version compound number of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X3rd_vc_number_of_empty_jumps)
  v2 <- as.numeric(d2$X3rd_vc_number_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "3rd version compound sum of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X3rd_vc_sum_of_empty_jumps)
  v2 <- as.numeric(d2$X3rd_vc_sum_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "3rd version compound avg of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X3rd_vc_avg_of_empty_jumps)
  v2 <- as.numeric(d2$X3rd_vc_avg_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }

  print("== 4th version compound metrics == ")
  metricName <- "4th version compound number of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X4th_vc_number_of_jumps)
  v2 <- as.numeric(d2$X4th_vc_number_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "4th version compound sum of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X4th_vc_sum_of_jumps)
  v2 <- as.numeric(d2$X4th_vc_sum_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "4th version compound avg of jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X4th_vc_avg_of_jumps)
  v2 <- as.numeric(d2$X4th_vc_avg_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "4th version compound number of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X4th_vc_number_of_empty_jumps)
  v2 <- as.numeric(d2$X4th_vc_number_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "4th version compound sum of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X4th_vc_sum_of_empty_jumps)
  v2 <- as.numeric(d2$X4th_vc_sum_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  metricName <- "4th version compound avg of empty jumps"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X4th_vc_avg_of_empty_jumps)
  v2 <- as.numeric(d2$X4th_vc_avg_of_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  print("== Aggregated metrics == ")
  metricName <- "Aggregated cycle lengths"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$Aggregated_cycle_length)
  v2 <- as.numeric(d2$Aggregated_cycle_length)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
	metricName <- "Aggregated jumps"; print(paste0("    ", metricName,":"))
	v1 <- as.numeric(d1$Aggregated_jumps)
	v2 <- as.numeric(d2$Aggregated_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
	metricName <- "Aggregated empty jumps"; print(paste0("    ", metricName,":"))
	v1 <- as.numeric(d1$Aggregated_empty_jumps)
	v2 <- as.numeric(d2$Aggregated_empty_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  metricName <- "Aggregated sum of megalomania severities"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$Sum_of_megalomania_severities)
  v2 <- as.numeric(d2$Sum_of_megalomania_severities)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  metricName <- "Aggregated number of megalomania severities"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$Number_of_megalomania_severities)
  v2 <- as.numeric(d2$Number_of_megalomania_severities)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  metricName <- "Aggregated average of megalomania severities"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$Average_of_megalomania_severities)
  v2 <- as.numeric(d2$Average_of_megalomania_severities)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  
  metricName <- "Aggregated inconsistency score"; print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$Aggregated_inconsistency_score)
  v2 <- as.numeric(d2$Aggregated_inconsistency_score)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
  analysis_results <- data.frame(metricNames, averages1, averages2, pvalues)
  if(nrow(analysis_results) != 0) {
    names(analysis_results) <- c("Metric names", paste0(name1, " averages"),paste0(name2, " averages"), "p-values")  
    analysis_results[2] <- round(analysis_results[2], 3)
    analysis_results[3] <- round(analysis_results[3], 3)
    analysis_results[4] <- round(analysis_results[4], 3)
  }
  
  return(analysis_results)
# 	metricName <- "Aggregated version placeholders"
# 	v1 <- as.numeric(d1$Aggregated.version.placeholders)
# 	v2 <- as.numeric(d2$Aggregated.version.placeholders)
# 	print(paste0("        ", name1, " average: ", mean(v1)))
# 	print(paste0("        ", name2, " average: ", mean(v2)))
# 	pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
# 	print(paste0("    p-value = ", pvalue))
}
results <- read.csv('results.csv', header=TRUE, stringsAsFactors=FALSE)
data = sqldf("select * from results group by Project_name having Number_of_versions == MAX(Number_of_versions)")
columns <- colnames(data)

print("OSS vs Proprietary ")
ossProjects <- data[data$Source_type == "OSS", ]
proprietaryProjects <- data[data$Source_type == "Proprietary", ]
analysis_results <- calculateAggregatedMetrics(ossProjects, proprietaryProjects, "OSS projects", "Proprietary projects")
print(analysis_results)
write.csv(analysis_results, "oss_analysis_results.csv", quote=FALSE)
print("")

print("SVN vs Git ")
projectsFromSvn <- data[data$Source == "svn", ]
projectsFromGit <- data[data$Source == "git", ]
analysis_results <- calculateAggregatedMetrics(projectsFromSvn, projectsFromGit, "Projects from SVN", "Projects from Git")
print(analysis_results)
write.csv(analysis_results, "vcs_analysis_results.csv", quote=FALSE)
print("")

print("DevTools vs non-dev tools ")
devTools <- data[data$Application_type == "DevTool", ]
notDevTools <- data[data$Application_type != "DevTool", ]
analysis_results <- calculateAggregatedMetrics(devTools,notDevTools, "Development tools", "Non-development tools")
print(analysis_results)
write.csv(analysis_results, "devtools_analysis_results.csv", quote=FALSE)
print("")

print("SDK projects vs non-SDK projects ")
sdkProjects <- data[data$Development_toolset != "--", ]
notSdkProjects <- data[data$Development_toolset == "--", ]
analysis_results <- calculateAggregatedMetrics(sdkProjects,notSdkProjects, "SDK projects", "Non-SDK projects")
print(analysis_results)
write.csv(analysis_results, "sdk_analysis_results.csv", quote=FALSE)
print("")

metrics <- c(
  "Number_of_versions", 
  "Number_of_megalomania_severities", 
  "Sum_of_megalomania_severities", 
  "Average_of_megalomania_severities", 
  "Aggregated_jumps",
  "Aggregated_empty_jumps",
  "Aggregated_inconsistency_score"
)

metricNames <- c()
averages1 <- c()
averages2 <- c()
names1 <- c()
names2 <- c()
pvalues <- c()

print("Project age analysis")

for(metricName in metrics) {
  frame <- analyzeColumnDependencies("Age", metricName)
  if(nrow(frame) != 0) {
    if(frame$pvalue < 0.05) {
      metricNames <- c(metricNames, as.character(frame$metricName)); 
      averages1 <- c(averages1, frame$average1); averages2 <- c(averages2, frame$average2)
      pvalues <- c(pvalues, frame$pvalue)
    }
  }
}

analysis_results <- data.frame(as.character(metricNames), averages1, averages2, pvalues)
names(analysis_results) <- c("Metric names", "Mean of 1st metric", "Mean of 2nd metric", "p-values")
print(analysis_results)
write.csv(analysis_results, "age_analysis_results.csv", quote=FALSE) 

metricNames <- c()
averages1 <- c()
averages2 <- c()
names1 <- c()
names2 <- c()
pvalues <- c()

print("Project team size analysis")

for(metricName in metrics) {
  frame <- analyzeColumnDependencies("Team_size", metricName)
  if(nrow(frame) != 0) {
    if(frame$pvalue < 0.05) {
      metricNames <- c(metricNames, as.character(frame$metricName)); 
      averages1 <- c(averages1, frame$average1); averages2 <- c(averages2, frame$average2)
      pvalues <- c(pvalues, frame$pvalue)
    }
  }
}

analysis_results <- data.frame(as.character(metricNames), averages1, averages2, pvalues)
names(analysis_results) <- c("Metric names", "Mean of 1st metric", "Mean of 2nd metric", "p-values")
print(analysis_results)
write.csv(analysis_results, "team_size_analysis_results.csv", quote=FALSE) 
metricNames <- c()
averages1 <- c()
averages2 <- c()
names1 <- c()
names2 <- c()
pvalues <- c()

print("Project application size analysis")

for(metricName in metrics) {
  frame <- analyzeColumnDependencies("Application_size", metricName)
  if(nrow(frame) != 0) {
    if(frame$pvalue < 0.05) {
      metricNames <- c(metricNames, as.character(frame$metricName)); 
      averages1 <- c(averages1, frame$average1); averages2 <- c(averages2, frame$average2)
      pvalues <- c(pvalues, frame$pvalue)
    }
  }
}

analysis_results <- data.frame(as.character(metricNames), averages1, averages2, pvalues)
names(analysis_results) <- c("Metric names", "Mean of 1st metric", "Mean of 2nd metric", "p-values")
print(analysis_results)
write.csv(analysis_results, "application_size_analysis_results.csv", quote=FALSE) 

metricNames <- c()
stDevs <- c()
medians <- c()
means <- c()
mins <- c()
maxs <- c()

metrics <- c(
  "Team_size", 
  "Age", 
  "Application_size", 
  "Number_of_versions"
)

for (metricName in metrics) {
  metricValues <- as.numeric(data[[metricName]][data[[metricName]] != "--"])
  metricValues <- metricValues[metricValues != 0]
  if(length(metricValues) == 0) {
    next()
  }
  metricNames <- c(metricNames, as.character(gsub("_" , " ", metricName)))
  stDevs <- c(stDevs, round(sd(metricValues), 4))
  medians <- c(medians, round(median(metricValues) , 4))
  means <- c(means, round(mean(metricValues), 4 ))
  mins <- c(mins, round(min(metricValues), 4 ))
  maxs <- c(maxs, round(max(metricValues), 4))
}

project_info <- data.frame(metricNames, stDevs, medians, means, mins, maxs)
names(project_info) <- c("Metric name", "Standard deviation", "Median", "Mean", "Min", "Max")
print(project_info)
write.csv(project_info, "project_info_analysis_results.csv", quote=FALSE)

metricNames <- c()
stDevs <- c()
medians <- c()
means <- c()
mins <- c()
maxs <- c()

metrics <- c(
  "Aggregated_jumps", 
  "Aggregated_empty_jumps",
  "Number_of_megalomania_severities",
  "Sum_of_megalomania_severities",
  "Average_of_megalomania_severities",
  "Aggregated_inconsistency_score",
  "X1st_vc_number_of_jumps",
  "X1st_vc_sum_of_jumps",
  "X1st_vc_avg_of_jumps",
  "X2nd_vc_number_of_jumps",
  "X2nd_vc_sum_of_jumps",
  "X2nd_vc_avg_of_jumps",
  "X3rd_vc_number_of_jumps",
  "X3rd_vc_sum_of_jumps",
  "X3rd_vc_avg_of_jumps",
  "X4th_vc_number_of_jumps",
  "X4th_vc_sum_of_jumps",
  "X4th_vc_avg_of_jumps",
  "Suffix_number_of_jumps",
  "Suffix_vc_sum_of_jumps",
  "Suffix_vc_avg_of_jumps"
)

for (metricName in metrics) {
  metricValues <- as.numeric(data[[metricName]][data[[metricName]] != "--"])
  metricValues <- metricValues[metricValues != 0]
  if(length(metricValues) == 0) {
    next()
  }
  metricNames <- c(metricNames, as.character(gsub("_" , " ", metricName)))
  stDevs <- c(stDevs, round(sd(metricValues), 4))
  medians <- c(medians, round(median(metricValues) , 4))
  means <- c(means, round(mean(metricValues), 4 ))
  mins <- c(mins, round(min(metricValues), 4 ))
  maxs <- c(maxs, round(max(metricValues), 4))
}

project_info <- data.frame(metricNames, stDevs, medians, means, mins, maxs)
names(project_info) <- c("Metric name", "Standard deviation", "Median", "Mean", "Min", "Max")
print(project_info)
write.csv(project_info, "metrics_analysis_results.csv", quote=FALSE)