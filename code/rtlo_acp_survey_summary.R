# code to create data summaries and figures based on 2022 data from the acp loon helicopter survey
# Dan Rizzolo
# 2022-12-07

# read in data: datatable output from ParkObserver Survey software used for data collection (Sadie Ulman, Tamara Zeller, Brian Uher-Koch) saved from Excel as CSV
data <- read.csv("data/2022_ACP_loon_data.csv")

data$count <-as.numeric(data$count)
data$nest <- as.numeric(data$nest)
data$pair <- as.numeric(data$pair)

# check 'em out
str(data)
# NB "count" refers to the number of individuals seen of the individual species at a location, not number of nests, as per Sadie Ulman's email from 31 Oct 2022
# e.g., if count = 2 and pair =1 , then count is indicating the 2 individuals that were identified as a pair

summary(data)
table(data$species)
table(data$Plot)
table(data$Plot, data$Visit)
table(data$Plot, data$Visit, data$species)

# convert to long format
data_wide <- cbind.data.frame(species = data$species, plot = data$Plot, visit = data$Visit, bird = data$count, nest = data$nest)
data_long <- reshape(data_wide,
                     varying = c("bird", "nest"),
                     v.names = "count",
                     timevar = "count_type",
                     times = c("bird", "nest"),
                     #new.row.names = 1:996,
                     direction = "long")
data_long <- as.data.frame(data_long)

data_long$count <-as.numeric(data_long$count)

# Check for missing zeros (plots visited and no birds or nests observed)
sum_plot <- aggregate(data_long$count ~ data_long$species + data_long$plot + data_long$visit + data_long$count_type, FUN = "sum")
colnames(sum_plot) <- c("species", "plot", "visit", "count_type", "count")
sum_plot

# Add observations with zero birds or nests during visits to all plots to data set# add records for plots visited that had 0 value for observations (count, pairm, nest), so they are represented in the data set
names(data)

# Add visits with zero counts
# RTLO
# Visit 1 Birds and Nests
# to do: create function with seq
rplot1visit1 <- c(501, 0, "RTLO", 1, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-26 12:00", "2022-06-26 13:00", 2022, NA, NA, NA, NA, NA, 501)
rplot4visit1 <- c(502, 0, "RTLO", 4, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-26 12:00", "2022-06-26 13:00", 2022, NA, NA, NA, NA, NA, 502)
rplot7visit1 <- c(503, 0, "RTLO", 7, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-26 12:00", "2022-06-26 13:00", 2022, NA, NA, NA, NA, NA, 503)
rplot11visit1 <- c(504, 0, "RTLO", 11, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-28 12:00", "2022-06-28 13:00", 2022, NA, NA, NA, NA, NA, 504)
rplot14visit1 <- c(505, 0, "RTLO", 14, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-28 12:00", "2022-06-28 13:00", 2022, NA, NA, NA, NA, NA, 505)
rplot15visit1 <- c(506, 0, "RTLO", 15, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-29 12:00", "2022-06-29 13:00", 2022, NA, NA, NA, NA, NA, 506)
rplot16visit1 <- c(507, 0, "RTLO", 16, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-04 12:00", "2022-07-04 13:00", 2022, NA, NA, NA, NA, NA, 507)
rplot17visit1 <- c(508, 0, "RTLO", 17, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-28 12:00", "2022-06-28 13:00", 2022, NA, NA, NA, NA, NA, 508)
rplot18visit1 <- c(509, 0, "RTLO", 18, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-29 12:00", "2022-06-29 13:00", 2022, NA, NA, NA, NA, NA, 509)
rplot20visit1 <- c(510, 0, "RTLO", 20, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-05 12:00", "2022-07-05 13:00", 2022, NA, NA, NA, NA, NA, 510)
rplot25visit1 <- c(511, 0, "RTLO", 25, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-06 12:00", "2022-07-06 13:00", 2022, NA, NA, NA, NA, NA, 511)

# Visit 2 Birds and Nests
rplot1visit2 <- c(512, 0, "RTLO", 1, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-28 12:00", "2022-06-28 13:00", 2022, NA, NA, NA, NA, NA, 512)
rplot7visit2 <- c(513, 0, "RTLO", 7, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-29 12:00", "2022-06-29 13:00", 2022, NA, NA, NA, NA, NA, 513)
rplot8visit2 <- c(514, 0, "RTLO", 8, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 514)
rplot9visit2 <- c(515, 0, "RTLO", 9, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 515)
rplot11visit2 <- c(516, 0, "RTLO", 11, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 516)
rplot12visit2 <- c(517, 0, "RTLO", 12, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-07 12:00", "2022-07-07 13:00", 2022, NA, NA, NA, NA, NA, 517)
rplot14visit2 <- c(518, 0, "RTLO", 14, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 518)
rplot15visit2 <- c(519, 0, "RTLO", 15, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-03 12:00", "2022-07-03 13:00", 2022, NA, NA, NA, NA, NA, 519)
rplot16visit2 <- c(520, 0, "RTLO", 16, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-07 12:00", "2022-07-07 13:00", 2022, NA, NA, NA, NA, NA, 520)
rplot17visit2 <- c(521, 0, "RTLO", 17, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 521)
rplot18visit2 <- c(522, 0, "RTLO", 18, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-03 12:00", "2022-07-03 13:00", 2022, NA, NA, NA, NA, NA, 522)
rplot20visit2 <- c(523, 0, "RTLO", 20, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-07-08 12:00", "2022-07-08 13:00", 2022, NA, NA, NA, NA, NA, 523)

# PALO
# Visit 1 Birds and Nests
pplot1visit1 <- c(524, 0, "PALO", 1, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-28 12:00", "2022-06-28 13:00", 2022, NA, NA, NA, NA, NA, 524)
pplot6visit1 <- c(532, 0, "PALO", 6, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 532)
pplot7visit1 <- c(525, 0, "PALO", 7, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-29 12:00", "2022-06-29 13:00", 2022, NA, NA, NA, NA, NA, 525)
pplot8visit1 <- c(526, 0, "PALO", 8, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 526)
pplot9visit1 <- c(527, 0, "PALO", 9, 1, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 527)

# Visit 2 Birds and Nests
pplot1visit2 <- c(528, 0, "PALO", 1, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-28 12:00", "2022-06-28 13:00", 2022, NA, NA, NA, NA, NA, 528)
pplot7visit2 <- c(529, 0, "PALO", 7, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-29 12:00", "2022-06-29 13:00", 2022, NA, NA, NA, NA, NA, 529)
pplot8visit2 <- c(530, 0, "PALO", 8, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 530)
pplot9visit2 <- c(531, 0, "PALO", 9, 2, 0, 0, NA, NA, NA, "added record for 0 obs", "2022-06-30 12:00", "2022-06-30 13:00", 2022, NA, NA, NA, NA, NA, 531)

# to do: turn into list and create a loop
# add these zero-count records to data frame
data <- rbind(data,rplot1visit1)
data <- rbind(data,rplot4visit1)
data <- rbind(data,rplot7visit1)
data <- rbind(data,rplot11visit1)
data <- rbind(data,rplot14visit1)
data <- rbind(data,rplot15visit1)
data <- rbind(data,rplot16visit1)
data <- rbind(data,rplot17visit1)
data <- rbind(data,rplot18visit1)
data <- rbind(data,rplot20visit1)
data <- rbind(data,rplot25visit1)

data <- rbind(data,rplot1visit2)
data <- rbind(data,rplot7visit2)
data <- rbind(data,rplot8visit2)
data <- rbind(data,rplot9visit2)
data <- rbind(data,rplot11visit2)
data <- rbind(data,rplot12visit2)
data <- rbind(data,rplot14visit2)
data <- rbind(data,rplot15visit2)
data <- rbind(data,rplot16visit2)
data <- rbind(data,rplot17visit2)
data <- rbind(data,rplot18visit2)
data <- rbind(data,rplot20visit2)

data <- rbind(data,pplot1visit1)
data <- rbind(data,pplot6visit1)
data <- rbind(data,pplot7visit1)
data <- rbind(data,pplot8visit1)
data <- rbind(data,pplot9visit1)

data <- rbind(data,pplot1visit2)
data <- rbind(data,pplot7visit2)
data <- rbind(data,pplot8visit2)
data <- rbind(data,pplot9visit2)

#--

data$count <-as.numeric(data$count)
data$nest <- as.numeric(data$nest)
data$pair <- as.numeric(data$pair)

# save data with zeros
#write.csv(data, "data/2022_ACP_loon_data_with_zeros.csv")

# SURVEY-SCALE SUMMARIES ####

# How many plots were surveyed?
plots <- unique(data$Plot)
count_plots_surveyed <- length(plots)

# What was the timeframe?
data$Timestamp_Local <- as.POSIXct(data$Timestamp_Local, format = "%Y-%m-%d %H:%M", tz = "America/Anchorage")
date_start <- min(data$Timestamp_Local)
date_end <- max(data$Timestamp_Local)
count_survey_days <- length(unique(as.Date(data$Timestamp_UTC)))

# How many plots were surveyed with 2 visits?
twice <- subset(data, Visit == 2)
count_plots_2visits <- length(unique(twice$Plot))

# Which plot was visited once?
twice_plot <- twice$Plot
all_plot <- data$Plot
setdiff(all_plot, twice_plot)

# How many total observations of loons
count_tot_loon_obs <- sum(data$count)
# on how many plots
nonzero_all_loon_obs <- subset(data, count != 0)
count_plots_tot_loon_obs <- length(unique(nonzero_all_loon_obs$Plot))

# how many total nests observations
count_tot_loon_nest_obs <- sum(data$nest)
# on how many plots
nonzero_all_nest_obs <- subset(data, nest != 0)
count_plots_tot_nest_obs <- length(unique(nonzero_all_nest_obs$Plot))

# SPECIES SCALE SUMMARIES ####
# How many loon observations by species?
count_obs_sp <- aggregate(data$count ~ data$species, FUN = "sum")
print(count_obs_sp)
# On how many plots?
all_obs <- subset(data, count != 0)
count_obs_plots_sp <- aggregate(all_obs$Plot ~ all_obs$species, FUN = "unique")
sp_obs_plots <- as.list(count_obs_plots_sp)
count_plots_obs_palo <- length(sp_obs_plots$`all_obs$Plot`[[1]])
count_plots_obs_rtlo <- length(sp_obs_plots$`all_obs$Plot`[[2]])

# How many nest observations by species?
count_nests_sp <- aggregate(data$nest ~ data$species, FUN = "sum")
print(count_nests_sp)
# On how many plots?
all_nests <- subset(data, nest != 0)
count_nests_plots_sp <- aggregate(all_nests$Plot ~ all_nests$species, FUN = "unique")
sp_nests_plots <- as.list(count_nests_plots_sp)
count_plots_nests_palo <- length(sp_nests_plots$`all_nests$Plot`[[1]])
count_plots_nests_rtlo <- length(sp_nests_plots$`all_nests$Plot`[[2]])

# COUNTS BY SPECIES AND PLOTS BY VISIT
# Visit 1 total observations
v1 < -subset(data, Visit == 1)
v1_obs<- aggregate(v1, count ~ species, FUN = "sum")
v1_obs
count_v1_palo_obs <- v1_obs[1,2]
count_v1_rtlo_obs <- v1_obs[2,2]

v1_nests<- aggregate(v1, nest ~ species, FUN = "sum")
v1_nests
count_v1_palo_nests <- v1_nests[1,2]
count_v1_rtlo_nests <- v1_nests[2,2]

v2 <- subset(data, Visit == 2)
v2_obs<- aggregate(v2, count ~ species, FUN = "sum")
v2_obs
count_v2_palo_obs <- v2_obs[1,2]
count_v2_rtlo_obs <- v2_obs[2,2]

v2_nests<- aggregate(v2, nest ~ species, FUN = "sum")
v2_nests
count_v2_palo_nests <- v2_nests[1,2]
count_v2_rtlo_nests <- v2_nests[2,2]

# plots with max counts
sum_plot_vis_sp <- aggregate(cbind(bird = data$count, nest = data$nest) ~ data$Plot + data$Visit + data$species, FUN ="sum")
colnames(sum_plot_vis_sp) <- c("plot", "visit", "species", "bird", "nest")
merge(aggregate(data = sum_plot_vis_sp, bird ~ species, max), sum_plot_vis_sp)
merge(aggregate(data = sum_plot_vis_sp, nest ~ species, max), sum_plot_vis_sp)
