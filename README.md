# BCB330_Shiny_Tool
#### Shiny tool developed in Shiny for landscape genetics data from the vegan library 

----

## 1 About this tool 


This tool visually represents principle component analysis on dune data from the vegan library in a live interactive format, Shiny. 


---- 

## 2 Preparations: Packages and Libraries 

The required libraries are installed and loaded

```R 
#Load shiny library
if (! require(shiny, quietly=TRUE)) {
  install.packages("shiny")
  library(shiny)
}

#Load vegan library
if (! require(vegan, quietly=TRUE)) {
  install.packages("vegan")
  library(vegan)
}
```

---- 

## 3 What this tool provides


#### Choosing which PC values you want to use on the y-axis

The drop down bar on the side panel allows for the choice between PC2 or PC3 (with PC2 as default) for the biplot with PC1.

#### Range restriction of the PC values 

The 2 slider toggles proceeding, allow restriction of the PC ranges. 

#### Zoom 

The last slider toggle allows for zooming up to the (0,0) coordinates. 

#### Summary of output

A brief summary of the input values for the output plot.
    
---- 
