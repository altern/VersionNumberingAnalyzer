source('util.R')

calculateAggregatedMetrics <- function(d1, d2) {
	print("    Aggregated jumps:")
	v1 <- as.numeric(d1$Aggregated.jumps)
	v2 <- as.numeric(d2$Aggregated.jumps)
	print(paste0("        OSS projects average: ", mean(v1)))
	print(paste0("        Proprietary projects average: ", mean(v2)))
	pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
	print(paste0("    p-value = ", pvalue))
	print("    Aggregated empty jumps:")
	v1 <- as.numeric(d1$Aggregated.empty.jumps)
	v2 <- as.numeric(d2$Aggregated.empty.jumps)
	print(paste0("        OSS projects average: ", mean(v1)))
	print(paste0("        Proprietary projects average: ", mean(v2)))
	pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
	print(paste0("    p-value = ", pvalue))
	print("    Aggregated megalomania severity:")
	v1 <- as.numeric(d1$Aggregated.megalomania.severity)
	v2 <- as.numeric(d2$Aggregated.megalomania.severity)
	print(paste0("        OSS projects average: ", mean(v1)))
	print(paste0("        Proprietary projects average: ", mean(v2)))
	pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
	print(paste0("    p-value = ", pvalue))
	print("    Aggregated cycle lengths:")
	v1 <- as.numeric(d1$Aggregated.cycle.length)
	v2 <- as.numeric(d2$Aggregated.cycle.length)
	print(paste0("        OSS projects average: ", mean(v1)))
	print(paste0("        Proprietary projects average: ", mean(v2)))
	pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
	print(paste0("    p-value = ", pvalue))
	print("    Aggregated version placeholders:")
	v1 <- as.numeric(d1$Aggregated.version.placeholders)
	v2 <- as.numeric(d2$Aggregated.version.placeholders)
	print(paste0("        OSS projects average: ", mean(v1)))
	print(paste0("        Proprietary projects average: ", mean(v2)))
	pvalue <- wilcox.test(v1, v2, paired=FALSE, exact=FALSE)$p.value
	print(paste0("    p-value = ", pvalue))


}
data <- read.csv('results.csv', header=TRUE, stringsAsFactors=FALSE)
columns <- colnames(data)

print("OSS vs Proprietary wilcox ")
ossProjects <- data[data$Source.type == "OSS", ]
proprietaryProjects <- data[data$Source.type == "Proprietary", ]
calculateAggregatedMetrics(ossProjects, proprietaryProjects)

print("SVN vs Git wilcox ")
projectsFromSvn <- data[data$Source == "svn", ]
projectsFromGit <- data[data$Source == "git", ]
calculateAggregatedMetrics(projectsFromSvn, projectsFromGit)

print("DevTools vs non-dev tools wilcox ")
devTools <- data[data$Application.type == "DevTool", ]
notDevTools <- data[data$Application.type != "DevTool", ]
calculateAggregatedMetrics(devTools,notDevTools)

print("SDK projects vs non-SDK projects wilcox ")
sdkProjects <- data[data$Development.toolset != "--", ]
notSdkProjects <- data[data$Development.toolset == "--", ]
calculateAggregatedMetrics(sdkProjects,notSdkProjects)

