# libraries
library(cluster)
library(dplyr)
library(tidyr)
library(data.table)

# dataset
rfull_df_long <- readRDS(here::here(
	"data",  "chla_clim.rds"
))

# wrangle data
dw <- rfull_df_long |> 
	filter(!is.na(value)) |> 
	select(-date) |>
	pivot_wider( names_from = doy, values_from = value) 
	

prop <- 0.05
set.seed(123)
dw_sample <- dw |> 
	sample_frac(prop) |> 
	# replace all NA with 0
	mutate(across(everything(), ~if_else(is.na(.), 0, .))) 


# kluster
k <- kmeans(dw_sample, centers = 5, nstart = 25)

