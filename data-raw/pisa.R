## code to prepare `pisa` dataset goes here
library(data.table)

#pisa_stan <- readRDS("data-raw/pisa_dataset.rds")
#str(pisa_stan)

pisa_ori <- readRDS("data-raw/pisa_original.rds")
str(pisa_ori)

## Column names
names(pisa_ori)[1] <- "ID"
names(pisa_ori)[2] <- "item"
names(pisa_ori)[4] <- "log_RT"

# factor to numeric
pisa_ori$item <- as.numeric(pisa_ori$item)

# response times in seconds
pisa_ori$RT <- exp(pisa_ori$log_RT)

# reshape to wide
pisaW_ori <- dcast(pisa_ori, ID ~ item, value.var = c("y", "RT", "log_RT"))

# all to data.frame
pisaW <- as.data.frame(pisaW_ori)
pisaL <- as.data.frame(pisa_ori)

# order of variables
pisaL <- pisaL[, c("ID", "item", "y", "RT", "log_RT")]

str(pisaW)
str(pisaL)

usethis::use_data(pisaW, overwrite = TRUE)
usethis::use_data(pisaL, overwrite = TRUE)


