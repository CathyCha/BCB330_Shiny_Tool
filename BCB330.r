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

data(dune)
data(dune.env)
dune.pca <- rda(dune)

#Define a server for the Shiny app
server <- function(input, output) {

	#Create a reactive Shiny plot to send to the ui
	output$pcaplot <- renderPlot({
	  #Range Slider x-axis PC#
	  dune.pca <- prcomp(dune)
	  dune.pca$rotation <- dune.pca$rotation[,c(1, as.integer(input$PCy))]
	  index <- (dune.pca$rotation[,1] > input$rangePC1[1] & dune.pca$rotation[,1] < input$rangePC1[2])
	  PCxAx <- dune.pca$rotation[index, 1] #PC1
	  PCyAx <- dune.pca$rotation[index, 2] #PC2 has to correspond to PC1 to make a valid plot
	  rotation <- cbind(PCxAx, PCyAx)
	  dune.pca$rotation <- rotation
	  biplot(dune.pca, xlim = c(-(input$Zoom), input$Zoom), ylim = c(-(input$Zoom), input$Zoom))

	  #Range Slider y-axis PC#
	  index <- (dune.pca$rotation[,2] > input$rangePC2[1] & dune.pca$rotation[,2] < input$rangePC2[2])
	  PCyAx2 <- dune.pca$rotation[index, 2] #PC2
	  PCxAx2 <- dune.pca$rotation[index, 1] #PC1 has to correspond to PC1 to make a valid plot
	  rotation <- cbind(PCxAx2, PCyAx2)
	  dune.pca$rotation <- rotation
	  biplot(dune.pca, xlim = c(-(input$Zoom), input$Zoom), ylim = c(-(input$Zoom), input$Zoom))
	  
	})

	output$description <- renderText(
	  {"This output is based on the pca analysis done on the dune data provided by the vegan package in R."}
	)
	
	output$info <- renderText({
	  toStr <- function(x) {
	    if(is.null(x)) return("NULL\n")
	    paste0("PC1 with PC", x, "\n")
	  }
	  rangeToStr <- function(x) {
	    if(is.null(x)) return("NULL\n")
	    paste0("(", x[1], ", ", x[2], ")", "\n")
	  }
	  viewPlane <- function(x) {
	    if(is.null(x)) return("NULL\n")
	    paste0("xlim = ", "(", x, ",", x, ")", "    ",
	           "ylim =", "(", x, ",", x, ")")
	  }
	
  	paste0(
  	  "PC plot of interest: ", toStr(input$PCy),
  	  "PC1 range restriction: ", rangeToStr(input$rangePC1),
  	  "PC of interest range restriction: ", rangeToStr(input$rangePC2),
  	  "Plane of view: ", viewPlane(input$Zoom)
  	)
	})
}

#Define the overall UI
ui <- fluidPage(
  titlePanel("BCB330 Shiny Tool - Cathy Cha"),
  sidebarLayout(
    #Sidebar Panel - create a input box to input PC values 
    sidebarPanel(
      # Input for which PC to use (default = PC1 and PC2)
      selectInput("PCy", "Choose y axis PC",
                  list(2, 3)
      ),
      
      #PC1 and PC2 sliders 
      sliderInput("rangePC1", 
                  label = "Range of interest PC1:",
                  min = -0.5, max = 0.5, value = c(-2, 2), step = 0.01),
      sliderInput("rangePC2", 
                  label = "Range of interest PC on y axis:",
                  min = -0.6, max = 0.6, value = c(-2, 2), step = 0.01), 
      sliderInput("Zoom", 
                  label = "Zoom",
                  min = 0.01, max = 0.5, value = 0.5, step = 0.01), 
      textOutput("description")
    ),		
    #space for the plot
    mainPanel(
      fluidRow(
        plotOutput("pcaplot")
      ),
      verbatimTextOutput("info")
    )
  )
)

shinyApp(ui = ui, server = server)