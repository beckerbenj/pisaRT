
library(data.table)
library(haven)
load("data-raw/PISACan2018M1.RData")

# dichotomize partial credit
for(i in names(respM1)) {
  if(max(respM1[,i], na.rm=T)<= 1 ) next()
  respM1[, i] <- ifelse(respM1[, i] == 2, yes = 1, no = 0)
}

### keep only cases without missings
# no missings on responses
respM1_2 <- respM1[rowSums(is.na(respM1)) == 0, ]
resptimesM1_2 <- resptimesM1[rowSums(is.na(respM1)) == 0, ]
# no missings on response times
respM1_3 <- respM1_2[rowSums(is.na(resptimesM1_2)) == 0, ]
resptimesM1_3 <- resptimesM1_2[rowSums(is.na(resptimesM1_2)) == 0, ]

# check
stopifnot(sum(is.na(respM1_3)) == 0)
stopifnot(sum(is.na(resptimesM1_3)) == 0)

# reshape into long format (drop all attributes)
dat_wide <- cbind(ID = NA, as.data.frame(respM1_3), as.data.frame(resptimesM1_3))
dat_wide <- zap_labels(dat_wide)
dat_wide <- zap_label(dat_wide)
dat_wide <- zap_formats(dat_wide)
dat_wide <- zap_widths(dat_wide)

# select 500 random test takers
set.seed(255)
dat_wide2 <- dat_wide[sample(1:nrow(dat_wide), size = 500), ]
dat_wide2$ID <- 1:500

# create log response times
dat_wide3 <- dat_wide2
for(i in names(resptimesM1_3)) {
  dat_wide3[, paste0(i, "_log")] <- log(dat_wide3[, i])
}

# format variable names
names_list <- list(y = paste0("y_", seq(ncol(respM1_3))), RT = paste0("RT_", seq(ncol(respM1_3))), log_RT = paste0("log_RT_", seq(ncol(respM1_3))))
names(dat_wide3) <- c("ID", names_list[["y"]], names_list[["RT"]], names_list[["log_RT"]])
str(dat_wide3)

# reshape to long
dat_long <- melt(as.data.table(dat_wide3), id.vars = "ID", measure.vars = names_list, variable.name = "item", variable.factor = FALSE)
dat_long$item <- as.numeric(dat_long$item)

# all to data.frame
pisaW <- as.data.frame(dat_wide3)
pisaL <- as.data.frame(dat_long)

str(pisaW)
str(pisaL)

usethis::use_data(pisaW, overwrite = TRUE)
usethis::use_data(pisaL, overwrite = TRUE)
