# load the libraries
library(raster)
library(dplyr)
library(tidyr)


# load the data
rfull <- stack("D:/Dropbox/R_projects/SV_phenology/data/CDS/daily_smoothed/daily_smoothed.nc")


rfull

# converto to data.frame
rfull_df <- as.data.frame(rfull, xy = TRUE, cells = TRUE, na.rm =F) |> 
	mutate(id =  1:n())

# convert in long format
rfull_df_long <- rfull_df |> 
	pivot_longer(cols = -c(x, y, id), names_to = "date", values_to = "value") |> mutate(doy =  as.numeric(gsub("X", "", date)))

saveRDS(rfull_df_long, here::here(
	"data",  "chla_clim.rds"
))
