# R code to create plot of counts by species, visit, and type (bird, nest)

# got packages
library(ggplot2)
library(ggpubr)

# Read in data with zero counts created with "rtlo_acp_survey_summary.R"
data <- read.csv("data/2022_ACP_loon_data_with_zeros.csv")

# check 'em out
str(data)
summary(data)

data$count <- as.numeric(data$count)
data$nest <- as.numeric(data$nest)

# reduce to necessary columns
data_wide <- cbind.data.frame(species = data$species, plot = data$Plot, visit = data$Visit, bird = data$count, nest = data$nest)

# rearrange to long format
data_long <- reshape(data_wide,
                     varying = c("bird", "nest"),
                     v.names = "count",
                     timevar = "count_type",
                     times = c("bird", "nest"),
                     new.row.names = 1:1060,
                     direction = "long")

# aggregate to sum counts y plot, species, count  type
sum_plot <- aggregate(data_long$count ~ data_long$species + data_long$plot + data_long$visit + data_long$count_type, FUN = "sum")
colnames(sum_plot) <- c("species", "plot", "visit", "count_type", "count")

# plot PALO
sum_palo <- subset(sum_plot, species == "PALO") # subset PALO data
p.palo <- ggplot() +
  geom_point(data = sum_palo, aes(x = plot, y = count, color = as.character(visit), shape = count_type), size = 2) +
  scale_x_continuous(breaks = seq(1, 25, by = 1))+
  scale_color_manual(values = c("darkblue", "royalblue1")) +
  labs(x = "Plot", y = "Count", color = "Visit", shape = "Count Type") +
  theme_bw() +
  theme(axis.text = element_text(size = 9),
        axis.title = element_text(size = 11, face = "bold"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        legend.position=c(0.9,0.75))
p.palo

# plot RTLO
sum_rtlo <- subset(sum_plot, species == "RTLO") # subset RTLO data
p.rtlo <- ggplot() +
  geom_point(data = sum_rtlo, aes(x = plot, y = count, color = as.character(visit), shape = count_type), size = 2) +
  scale_x_continuous(breaks = seq(1, 25, by = 1))+
  scale_color_manual(values = c("red4", "red")) +
  labs(x = "Plot", y = "Count", color = "Visit", shape = "Count Type") +
  theme_bw() +
  theme(axis.text = element_text(size = 9),
        axis.title = element_text(size = 11, face = "bold"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        legend.position=c(0.9,0.75))
p.rtlo

# create panel fig with ggpubr::ggarrange
panel<-ggarrange(p.palo,p.rtlo,
                 widths=c(6,6),
                 labels=c("A","B"),
                 ncol=1, nrow=2, common.legend=FALSE,
                 legend="top")
panel

# save figure
ggsave("output/figures/plot_palo_rtlo_counts_plot.png", width=6.5, height=6, units="in", dpi=300)
