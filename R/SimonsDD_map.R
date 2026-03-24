# R script to map the genome sampling locations of the Simons Genome Diversity project 
# Mallick, S., Li, H., Lipson, M. et al. The Simons Genome Diversity Project: 300 genomes from 142 diverse populations. 
# Nature 538, 201–206 (2016). https://doi.org/10.1038/nature18964

df <- read.csv(file="SGDP_metadata.csv", header=T, sep=",", stringsAsFactors=T)
# colorblind color palette from http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#a-colorblind-friendly-palette
cbbPalette <- c("#000000", "#E69F00", "#0072B2", "#CC79A7", "#56B4E9", "#D55E00", "#009E73", "#F0E442")

#import ggplot2 to make graph and jpeg to import map image created with map function 
library(ggplot2)
library(ggpubr) #need for adding map as background_image (I think)
library(jpeg)

#create world map with grey continents, white background, a y latitude of 80 (I think), and some other features I don't fully understand)
map('world',col="grey", fill=TRUE, bg="white", lwd=0.05, mar=rep(0,4),border=0, ylim=c(-80,80))
back_map <- readJPEG("world_map_light.jpeg")

# plot latitude and longitude of each genome sampled for SGDP. Set y-axis to latitude 80 to match map
g <- ggplot(df, aes(x=Longitude, y=Latitude)) + background_image(back_map) + ylim(c(-80,80))
gc <- g + geom_point(aes(color=Region, shape=Region)) + 
  labs(title = "SGDP Sampling Locations") +
  theme(legend.key=element_rect(fill='white')) +
  #set shapes manually 
  scale_shape_manual(values=c(0,7,3,1,10,4,6)) + 
  
  #set colors to colorblind-friendly cbb palette
  scale_color_manual(values=cbbPalette) 
print(gc)
