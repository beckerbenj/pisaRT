# pisaRT

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/pisaRT)](https://CRAN.R-project.org/package=pisaRT)
[![R-CMD-check](https://github.com/beckerbenj/pisaRT/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/beckerbenj/pisaRT/actions/workflows/R-CMD-check.yaml)
[![](http://cranlogs.r-pkg.org/badges/grand-total/pisaRT?color=blue)](https://cran.r-project.org/package=pisaRT)
<!-- badges: end -->

## Overview

`pisaRT` contains a small example data set from the PISA 2018 study with scored responses, response times and log transformed response times on item level. The original files can be retrieved as the "Cognitive items total time/visits data file" from <https://www.oecd.org/pisa/data/2018database/>. 

## Installation

```R
# Install pisaRT from CRAN
install.packages("pisaRT")
```

## Usage

```R
# load package
library(pisaRT)

# data structure of wide format data
str(pisaW)

# data structure of long format data
str(pisaL)
```
