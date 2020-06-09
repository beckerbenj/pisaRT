## code to prepare `pisa` dataset goes here
library(data.table)

#pisa_stan <- readRDS("data-raw/pisa_dataset.rds")
#str(pisa_stan)

pisa_ori <- readRDS("data-raw/pisa_original.rds")
str(pisa_ori)

## Column names
names(pisa_ori)[1] <- "ID"
names(pisa_ori)[2] <- "item"

# factor to numeric
pisa_ori$item <- as.numeric(pisa_ori$item)

# reshape to wide
pisaW_ori <- dcast(pisa_ori, ID ~ item, value.var = c("y", "logt"))

# all to data.frame
pisaW <- as.data.frame(pisaW_ori)
pisaL <- as.data.frame(pisa_ori)

str(pisaW)
str(pisaL)

usethis::use_data(pisaW)
usethis::use_data(pisaL)
