# Phosphorus data
# load Libraries
library(readr)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(tidyr)

# read data
phosphors <- read_table("path") 
phosphors <- data.frame(phosphors)

---------------------------------------------
day  ID1         ID2           ID3.......           IDn
1    1005.873    1194.078      970.5353             ...
2    ...
3    ...
---------------------------------------------

# data preparation
phosphors_n = c(as.numeric(phosphors[1,-1]),as.numeric(phosphors[2,-1]),as.numeric(phosphors[3,-1]))
phosphors_d = c(rep("day_1", length(as.numeric(phosphors[1,-1]))), rep("day_2", length(as.numeric(phosphors[2,-1]))), rep("day_3", length(as.numeric(phosphors[3,-1]))))

phosphors_d = as.factor(phosphors_d)

data_phosphors = data.frame(group = phosphors_d, value = phosphors_n)

# log transformation of value 
data_phosphors$value = log(data_phosphors$value + 1) # add 10 to avoid log(0)



# anove
anova_res = aov(value ~ group, data = data_phosphors)
summary(anova_res)

# Tukey's HSD test
tukey_res = TukeyHSD(anova_res)
tukey_res

# Plotting the results
ggplot(data_phosphors, aes(x = group, y = value)) +
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", shape = 5, size = 3, color = "red") +
  labs(title = "Boxplot of phosphors Data by Day", x = "Day", y = "phosphors Value") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

plot(anova_res, las = 1, col = "blue", main = "Tukey's HSD Test Results")


## Tukey HSD Test

library(ggplot2)
library(dplyr)
library(patchwork)  # For combining plots

# Prepare data
tukey_df <- as.data.frame(tukey_res$group)
tukey_df$comparison <- rownames(tukey_df)
colnames(tukey_df) <- c("diff", "lwr", "upr", "p_adj", "comparison")
tukey_df$significant <- tukey_df$p_adj < 0.05

# Plot 1: Mean differences with CI
p1 <- ggplot(tukey_df, aes(x = comparison, y = diff, ymin = lwr, ymax = upr, color = significant)) +
  geom_pointrange(position = position_dodge(width = 0.3)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black")) +
  labs(
    title = "Tukey HSD: Mean Differences with 95% CI",
    x = NULL,
    y = "Difference"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Plot 2: Adjusted p-values
p2 <- ggplot(tukey_df, aes(x = comparison, y = p_adj, fill = significant)) +
  geom_col() +
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "blue") +
  scale_fill_manual(values = c("TRUE" = "red", "FALSE" = "gray70")) +
  labs(
    title = "Adjusted p-values (Tukey)",
    x = "Comparison",
    y = "p-value"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Combine the two plots
p1 / p2  # patchwork syntax: stack vertically
