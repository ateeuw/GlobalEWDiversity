if(Sys.info()["nodename"] == "IDIVNB193"){
  setwd("C:\\restore2\\hp39wasi\\sWorm\\EarthwormAnalysis\\")
}

if(Sys.info()["nodename"] == "TSGIS02"){
  setwd("C:/sWorm/EarthwormAnalysis")
}

if(!dir.exists("Figures")){
  dir.create("Figures")
}
figures <- "Figures"

## Create map
library(raster)
library(RColorBrewer)
library(maps)
library(mapdata)
library(maptools)
library(sp)
library(viridis)

source("Functions/cornerlabel2.R")

#######################################
# variables
######################################

wide_cm <- 12
wide_inch <- 4.75
point_size <- 10
plotlabcex <- 1
legendcex <- 0.8
resdpi <- 300
############################################################
## 'Global'
############################################################

# bkg <- raster("I:\\sWorm\\ProcessedGLs_revised\\CHELSA_bio10_1_BiomassCutScaled.tif")
bkg <- raster("D:\\sWorm\\ProcessedGL\\Datasets\\bio10_1.tif")
## The percentage that map is cut off at top and bottom


############################################################
## Species Richness
############################################################

# results <- "I:\\sDiv-PostDocs-Work\\Phillips\\sWorm\\SpatialAnalysis\\Results\\Revised\\Richness"
results <- "D:\\sWorm\\Results\\Richness"

# regions <- c("africa", "asia", "europe", "latin_america", "north_america", "west_asia")

resultRaster <- "spRFinalRaster.tif"

africa <- raster(file.path(results, "africa", resultRaster))
africa <- exp(africa)
asia <-  raster(file.path(results, "asia", resultRaster))
asia <- exp(asia)
europe <- raster(file.path(results, "europe", resultRaster))
europe <- exp(europe) 
latin_america <- raster(file.path(results, "latin_america", resultRaster))
latin_america <- exp(latin_america) 
north_america <- raster(file.path(results, "north_america", resultRaster))
north_america <- exp(north_america) 
west_asia <- raster(file.path(results, "west_asia", resultRaster))
west_asia <- exp(west_asia)
# 
# hist(africa)
# hist(asia)
# hist(europe)
# hist(latin_america)
# hist(north_america)
# hist(west_asia)


minV <-min(c(minValue(africa),
             minValue(asia),
             minValue(europe),
             minValue(latin_america),
             minValue(north_america),
             minValue(west_asia)))

maxV <-max(c(maxValue(africa),
             maxValue(asia),
             maxValue(europe),
             maxValue(latin_america),
             maxValue(north_america),
             maxValue(west_asia)))



colbrks <-  c(minV, seq(1, 6, length.out = 198), maxV)

r.cols <- magma(199)

# png(file.path(figures, "Richness.png"),width=17.5,height=8.75,units="cm",res=resdpi)
pdf(file.path(figures, "Richness.pdf"),width= wide_inch, height= wide_inch/2, pointsize = point_size)
nf <- layout(matrix(c(1,2), 2,1, byrow = TRUE), c(5, 1), c(5, 1))
# layout.show(nf)
par(mar=c(0.1,0.1,0.1,0.1))

image(bkg, ylim = c(-90, 90), xlim = c(-180, 180), col = "gray90", xaxt="n", yaxt="n", ylab="", xlab="", bty="n")


image(africa, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(asia, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(europe, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(latin_america, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(north_america, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(west_asia, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")


corner.label2(label = "B", x = -1, y = 1, cex=plotlabcex, font = 2)

## Legend
par(mar=c(0.1,13,1,13))
scale <- c(rep(magma(199)[1], times = 20), rep(magma(199), each = 2), rep(magma(199)[199], times = 20))
b <- barplot(rep(1, 438), col = scale, border =scale, axes = FALSE )
# b
# abline(v = 20, col = "white")
# abline(v = b[418], col = "black")

mtext(1, at = b[20], cex = legendcex)
mtext(6, at = b[418],cex = legendcex)
mtext("Number of species", at = 250, cex = legendcex)
dev.off()



############################################################
## BIOMASS
############################################################


# regions <- c("africa", "asia", "europe", "latin_america", "north_america", "west_asia")

# results <- "I:\\sDiv-PostDocs-Work\\Phillips\\sWorm\\SpatialAnalysis\\Results\\Revised\\Biomass"
results <- "D:\\sWorm\\Results\\Biomass"
regions <- c("asia", "africa", "europe", "latin_america", "north_america", "west_asia")
resultRaster <- "BiomassFinalRaster.tif"
 
africa <- raster(file.path(results, "africa", resultRaster))
africa <- exp(africa) - 1
asia <-  raster(file.path(results, "asia", resultRaster))
asia <- exp(asia) - 1
europe <- raster(file.path(results, "europe", resultRaster))
europe <- exp(europe) - 1
latin_america <- raster(file.path(results, "latin_america", resultRaster))
latin_america <- exp(latin_america) - 1
north_america <- raster(file.path(results, "north_america", resultRaster))
north_america <- exp(north_america) - 1
west_asia <- raster(file.path(results, "west_asia", resultRaster))
west_asia <- exp(west_asia) - 1

#   
# hist(africa, ylim =c(1, 1000))
# hist(asia, ylim =c(1, 1000))
# hist(europe, xlim = c(0, 50), breaks = seq(minValue(europe),  maxValue(europe), by = 1))
# hist(latin_america, ylim =c(1, 1000))
# hist(north_america, ylim =c(1, 1000))
# hist(west_asia, ylim =c(1, 1000))
  
minV <-min(c(minValue(africa),
             minValue(asia),
             minValue(europe),
             minValue(latin_america),
             minValue(north_america),
             minValue(west_asia)))
 
maxV <-max(c(maxValue(africa),
             maxValue(asia),
             maxValue(europe),
             maxValue(latin_america),
             maxValue(north_america),
             maxValue(west_asia)))
 
 

colbrks <-  c(minV, seq(1, 150, length.out = 198), maxV)

r.cols <- magma(199)

#png(file.path(figures, "Biomass.png"),width=17.5,height=8.75,units="cm",res=resdpi)
pdf(file.path(figures, "Biomass.pdf"),width= wide_inch, height= wide_inch/2, pointsize = point_size)

nf <- layout(matrix(c(1,2), 2,1, byrow = TRUE), c(5, 1), c(5, 1))
# layout.show(nf)
par(mar=c(0.1,0.1,0.1,0.1))
image(bkg, ylim = c(-90, 90), xlim = c(-180, 180), col = "gray90", xaxt="n", yaxt="n", ylab="", xlab="", bty="n")

image(africa, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(asia, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(europe, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(latin_america, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(north_america, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(west_asia, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")

corner.label2(label = "D", x = -1, y = 1, cex = plotlabcex, font = 2)


## Legend
par(mar=c(1,13,1,13))
scale <- c(rep(magma(199)[1], times = 20), rep(magma(199), each = 2), rep(magma(199)[199], times = 20))
b <- barplot(rep(1, 438), col = scale, border =scale, axes = FALSE )
mtext("1", at =b[20], cex = legendcex)
mtext("150", at = b[418], cex = legendcex)
mtext(expression("Biomass (grams per" ~ m^{2} ~ ")"), at = 250, cex = legendcex)
dev.off()



############################################################
## ABUNDANCE
############################################################




# results <- "I:\\sDiv-PostDocs-Work\\Phillips\\sWorm\\SpatialAnalysis\\Results\\Revised\\Abundance"
results <- "D:\\sWorm\\Results\\Abundance"

regions <- c("asia", "afria", "europe", "latin_america", "north_america", "west_asia")
resultRaster <- "AbundanceFinalRaster.tif"

africa <- raster(file.path(results, "africa", resultRaster))
africa <- exp(africa) - 1
asia <-  raster(file.path(results, "asia", resultRaster))
asia <- exp(asia) - 1
europe <- raster(file.path(results, "europe", resultRaster))
europe <- exp(europe) - 1
latin_america <- raster(file.path(results, "latin_america", resultRaster))
latin_america <- exp(latin_america) - 1
north_america <- raster(file.path(results, "north_america", resultRaster))
north_america <- exp(north_america) - 1
west_asia <- raster(file.path(results, "west_asia", resultRaster))
west_asia <- exp(west_asia) - 1

minV <-min(c(minValue(africa),
             minValue(asia),
             minValue(europe),
             minValue(latin_america),
             minValue(north_america),
             minValue(west_asia)))

maxV <-max(c(maxValue(africa),
             maxValue(asia),
             maxValue(europe),
             maxValue(latin_america),
             maxValue(north_america),
             maxValue(west_asia)))

# hist(asia)
# hist(africa)
# hist(europe)
# hist(north_america)
# hist(latin_america)
# hist(west_asia)



###########################################

colbrks <-  c(minV, seq(5, 150, length.out = 198), maxV)

r.cols <- magma(199)

#png(file.path(figures, "Abundance.png"),width=17.5,height=8.75,units="cm",res=resdpi)
pdf(file.path(figures, "Abundance.pdf"),width= wide_inch, height= wide_inch/2, pointsize = point_size)

nf <- layout(matrix(c(1,2), 2,1, byrow = TRUE), c(5, 1), c(5, 1))
# layout.show(nf)
par(mar=c(0.1,0.1,0.1,0.1))

image(bkg, ylim = c(-90, 90), xlim = c(-180, 180), col = "gray90", xaxt="n", yaxt="n", ylab="", xlab="", bty="n")

image(africa, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(asia, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(europe, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(latin_america, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(north_america, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")
image(west_asia, col=r.cols, add = TRUE, breaks=colbrks, xaxt="n", yaxt="n", ylab="", xlab="")

corner.label2(label = "C", x = -1, y = 1, cex = plotlabcex, font = 2)


## Legend
par(mar=c(1,13,1,13))
scale <- c(rep(magma(199)[1], times = 20), rep(magma(199), each = 2), rep(magma(199)[199], times = 20))
b <- barplot(rep(1, 438), col = scale, border =scale, axes = FALSE )
mtext("5", at = b[20], cex = legendcex)
mtext("150", at = b[418], cex = legendcex)
mtext(expression("Abundance (individuals per" ~ m^{2} ~ ")"), at = 250, cex = legendcex)

dev.off()



