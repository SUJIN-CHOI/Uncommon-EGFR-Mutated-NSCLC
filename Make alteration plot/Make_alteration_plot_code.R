### Load libraries
library(dplyr)
library(reshape2)
library(maftools)
library(devtools)
library(ComplexHeatmap)


### Load data
alteration_df <- read.csv("./Frequent_alteration.csv", row.names = 1)
colnames(alteration_df) <- str_replace_all(colnames(alteration_df), "[.]", "-")


### color setting
col = c("Amplification" ="#ff001e", 
        "Deletion"="#0033FF", 
        "Frame shift indel"="#F4BC43", 
        "Nonsense"="#20B2AA",
        "Missense"="forestgreen")


### function
alter_fun = list(
  background = function(x,y,w,h)grid.rect(x, y, w*0.85, h*0.85, gp = gpar(fill = "#f7f7f7", col = NA)),
  "Amplification" = function(x, y, w, h) grid.rect(x, y, w*0.85, h*0.85, gp = gpar(fill = col["Amplification"], col = NA)),
  "Deletion" = function(x, y, w, h) grid.rect(x, y, w*0.85, h*0.85, gp = gpar(fill = col["Deletion"], col = NA)),
  "Frame shift indel" = function(x, y, w, h) grid.rect(x, y, w*0.85, h*0.85, gp = gpar(fill = col["Frame shift indel"], col = NA)),
  "Nonsense" = function(x, y, w, h) grid.rect(x, y, w*0.85, h*0.4, gp = gpar(fill = col["Nonsense"], col = NA)),
  "Missense" = function(x, y, w, h) grid.rect(x, y, w*0.85, h*0.4, gp = gpar(fill = col["Missense"], col = NA)))


### ComplexHeatmap
ht = oncoPrint(alteration_df, 
               alter_fun = alter_fun, 
               col=col, 
               show_column_names = TRUE,
               column_order = colnames(alteration_df),
               row_order = rownames(alteration_df),
               row_names_side = "left",
               pct_side = "right",
               row_names_gp = gpar(fontface = "italic", fontsize = 9),
               column_names_gp = gpar(fontsize=9),
               row_title_gp = gpar(fontsize=9),
               column_title_gp = gpar(fontsize=9),
               show_heatmap_legend = TRUE, 
               alter_fun_is_vectorized = FALSE,
               pct_gp = gpar(fontsize=9)) 


### Save
pdf(file=paste0('./Alteration_plot.pdf'), width = 5.5, height = 6)
draw(ht, 
     row_sub_title_side = "left", 
     heatmap_legend_side = "right", 
     annotation_legend_side = "right")

dev.off()





