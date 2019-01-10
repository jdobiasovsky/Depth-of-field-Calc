#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

#global functions
hyperfocal <- function(foc_length, aperture, coc){
  print("Calculating hyperfocal")
  hyfocal = (foc_length^2 / (aperture*coc))
  return(hyfocal)
}

dof <- function(hyperfocal, distance, foc_length){
  print("Calculating DoF")
  nearpoint <- (hyperfocal * distance) / (hyperfocal + (distance - foc_length))
  farpoint <- (hyperfocal * distance)*(hyperfocal - (distance - foc_length))
  totaldof <- farpoint - nearpoint
  
  return(c(nearpoint, farpoint, totaldof))
}


# Define server logic
shinyServer(function(input, output) {
  output$sensormessage <- renderText({
    paste("Displaying results for ", input$sensorsize, " sensor size")
  })
  output$hyperfocal <- renderText({
    if (input$sensorsize=="full frame"){
      coc <- 0.02501
    }
    if (input$sensorsize=="APS-C"){
      coc <- 0.019948
    }
    hyfocal <- (input$focal^2 / (input$aperture*coc))
    return(hyfocal)
  })
  #output$dofresults <- renderTable()
})
