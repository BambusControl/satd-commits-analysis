### Read dataset
satd_dataset <- read.csv("/Users/Aurora/Downloads/satd-commits-merged-dataset.csv")

### Create subsets
# Subset data for non_debt commits
non_debt_subset <- satd_dataset[satd_dataset$classification == "non_debt", ]

# Subset data for debt commits (excluding non_debt)
debt_subset <- satd_dataset[satd_dataset$classification != "non_debt", ]

### Function to remove outliers
remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

### Create statistics for debt vs non_debt
# Remove outliers from net_lines and num_files of overall dataset
satd_net_lines <- remove_outliers(satd_dataset$net_lines)
satd_num_files <- remove_outliers(satd_dataset$num_files)

# Create vectors for the needed columns, removing outliers
non_debt_net_lines <- remove_outliers(non_debt_subset$net_lines)
non_debt_num_files <- remove_outliers(non_debt_subset$num_files)
non_debt_dmm_unit_complexity <- remove_outliers(non_debt_subset$dmm_unit_complexity)

debt_net_lines <- remove_outliers(debt_subset$net_lines)
debt_num_files <- remove_outliers(debt_subset$num_files)
debt_dmm_unit_complexity <- remove_outliers(debt_subset$dmm_unit_complexity)

# Create data frame for non_debt
non_debt_combined_data <- data.frame(
  num_files = non_debt_num_files,
  net_lines = non_debt_net_lines,
  dmm_unit_complexity = non_debt_dmm_unit_complexity
)

# Create data frame for debt
debt_combined_data <- data.frame(
  num_files = debt_num_files,
  net_lines = debt_net_lines,
  dmm_unit_complexity = debt_dmm_unit_complexity
)

# Print summary of non_debt_combined_data
summary_non_debt <- summary(non_debt_combined_data)
print("Summary for non_debt_combined_data:")
print(summary_non_debt)

# Print summary of debt_combined_data
summary_debt <- summary(debt_combined_data)
print("Summary for debt_combined_data:")
print(summary_debt)

### Sd 
# Calculate standard deviation for non_debt
sd_non_debt_files <- sd(non_debt_num_files, na.rm = TRUE)
sd_non_debt_lines <- sd(non_debt_net_lines, na.rm = TRUE)
sd_non_debt_complexity <- sd(non_debt_dmm_unit_complexity, na.rm = TRUE)

# Calculate standard deviation for debt
sd_debt_files <- sd(debt_num_files, na.rm = TRUE)
sd_debt_lines <- sd(debt_net_lines, na.rm = TRUE)
sd_debt_complexity <- sd(debt_dmm_unit_complexity, na.rm = TRUE)

# Printing sd's
cat("Standard Deviation for Non-Debt Files:", sd_non_debt_files, "\n")
cat("Standard Deviation for Non-Debt Lines:", sd_non_debt_lines, "\n")
cat("Standard Deviation for Non-Debt Complexity:", sd_non_debt_complexity, "\n")

cat("Standard Deviation for Debt Files:", sd_debt_files, "\n")
cat("Standard Deviation for Debt Lines:", sd_debt_lines, "\n")
cat("Standard Deviation for Debt Complexity:", sd_debt_complexity, "\n")

### Plots
# Boxplots

# Load the ggplot2 library if not already loaded
library(ggplot2)

# Create a boxplot using ggplot2
ggplot(satd_dataset, aes(x = classification, y = satd_net_lines)) +
  geom_boxplot(fill = "lightgreen", color = "darkgreen") +
  labs(title = "Boxplot of net_lines (outliers removed) by Classification", 
       x = "Classification", y = "Net Lines (outliers removed)") +
  theme_minimal()

# Create a boxplot using ggplot2
ggplot(satd_dataset, aes(x = classification, y = satd_num_files)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(title = "Boxplot of num_files (outliers removed) by Classification", 
       x = "Classification", y = "Num Files(outliers removed)") +
  theme_minimal()

par(mfrow = c(2, 2))

# Histograms
hist(non_debt_num_files, col = "lightblue", main = "Histogram of Number of Files")
hist(non_debt_net_lines, col = "lightgreen", main = "Histogram of Net Lines")
hist(debt_num_files, col = "lightblue", main = "Histogram of Number of Files (Debt)")
hist(debt_net_lines, col = "lightgreen", main = "Histogram of Net Lines (Debt)")

### Tests
# Correlation analysis
cor(satd_num_files, satd_net_lines, use='complete.obs')
cor(non_debt_num_files, non_debt_net_lines, use='complete.obs')
cor(debt_num_files, debt_net_lines, use='complete.obs')

# Statistical Tests
satd_dataset$group <- ifelse(satd_dataset$classification == "non_debt", "non_debt", "debt")
t_test_satd_num_files <- t.test(satd_num_files ~ group, data = satd_dataset)
t_test_satd_net_lines <- t.test(satd_net_lines ~ group, data = satd_dataset)

wilcox_satd_num_files <- wilcox.test(satd_num_files ~ group, data = satd_dataset)
wilcox_satd_net_lines <- wilcox.test(satd_net_lines ~ group, data = satd_dataset)

# Printing results
cat("T-Test for SATD Number of Files:")
print(t_test_satd_num_files)

cat("T-Test for SATD Net Lines:")
print(t_test_satd_net_lines)

cat("Wilcoxon Test for SATD Number of Files:")
print(wilcox_satd_num_files)

cat("Wilcoxon Test for SATD Net Lines:")
print(wilcox_satd_net_lines)



