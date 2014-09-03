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
  
  print("== 3rd version compound metrics == ")
  metricName <- "3rd version compound number of jumps"
  print(paste0("    ", metricName,":"))
  v1 <- as.numeric(d1$X3rd_vc_number_of_jumps)
  v2 <- as.numeric(d2$X3rd_vc_number_of_jumps)
  pvalue <- printTestResults(v1, v2, name1, name2)
  if(pvalue < 0.05) {
    metricNames <- c(metricNames, metricName); 
    averages1 <- c(averages1, mean(v1)); averages2 <- c(averages2, mean(v2))
    names1 <- c(names1, name1); names2 <- c(names2, name2)
    pvalues <- c(pvalues, pvalue)
  }
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
write.csv(analysis_results, "oss_analysis_results.csv")
print("")

print("SVN vs Git ")
projectsFromSvn <- data[data$Source == "svn", ]
projectsFromGit <- data[data$Source == "git", ]
analysis_results <- calculateAggregatedMetrics(projectsFromSvn, projectsFromGit, "Projects from SVN", "Projects from Git")
print(analysis_results)
write.csv(analysis_results, "vcs_analysis_results.csv")
print("")

print("DevTools vs non-dev tools ")
devTools <- data[data$Application_type == "DevTool", ]
notDevTools <- data[data$Application_type != "DevTool", ]
analysis_results <- calculateAggregatedMetrics(devTools,notDevTools, "Development tools", "Non-development tools")
print(analysis_results)
write.csv(analysis_results, "devtools_analysis_results.csv")
print("")

print("SDK projects vs non-SDK projects ")
sdkProjects <- data[data$Development_toolset != "--", ]
notSdkProjects <- data[data$Development_toolset == "--", ]
analysis_results <- calculateAggregatedMetrics(sdkProjects,notSdkProjects, "SDK projects", "Non-SDK projects")
print(analysis_results)
write.csv(analysis_results, "sdk_analysis_results.csv")
print("")

