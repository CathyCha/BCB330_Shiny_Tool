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

## 3 How to manipulate statistical visualization 


    
---- 
