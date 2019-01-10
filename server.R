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
get_hyperfocal <- function(foc_length, aperture, coc){
  hyperfocal = (sqrt(foc_length) / (aperture*coc))
  return(hyperfocal)
}


setcoc <- function(sensorsize_choice){
  # based on selected sensor size from ui, set circle of confusion in mm
  if (sensorsize_choice=="full frame"){
    coc <- 0.02501}
  
  if (sensorsize_choice=="APS-C"){
    coc <- 0.019948}
  return(coc)
}


get_nicer_dof_values <- function(convertto, list){
  if (convertto == "m"){
    divideby <- 1000
  }
  if (convertto == "cm"){
    divideby <- 100
  }
  lapply(list, round, 2)
  
  return(list/divideby)
}


get_dof <- function(hyperfocal, distance, foc_length){
  nearpoint <- (hyperfocal * distance) / (hyperfocal + (distance - foc_length))
  farpoint <- (hyperfocal * distance)*(hyperfocal - (distance - foc_length))
  totaldof <- farpoint - nearpoint
  print(nearpoint)
  print(farpoint)
  print(totaldof)
  return(c(nearpoint, farpoint, totaldof))
}


# Define server logic
shinyServer(function(input, output) {
  
  #Short message informing about picked sensor size in main panel
  output$sensor_message <- renderText({
    paste("Displaying results for ", input$sensorsize, " sensor size")
  })
  
  #Short message about calculated hyperfocal length
  output$hyperfocal_message <- renderText({
    coc <- setcoc(sensorsize_choice = input$sensorsize)
    hyperfocal <- get_hyperfocal(foc_length = input$focal_len, aperture = input$aperture, coc = coc)
    paste("Lens hyperfocal distance is: ", round(hyperfocal/1000, digits = 2), " m (", round(hyperfocal/10,digits = 2), " cm)")
  })
  output$dof_results <- renderTable({
    coc <- setcoc(sensorsize_choice = input$sensorsize)
    hyperfocal <- get_hyperfocal(foc_length = input$focal_len, aperture = input$aperture, coc = coc)
    dof_values <- get_dof(hyperfocal = hyperfocal, distance = input$dist, foc_length = input$focal_len)
    rownames = c("Nearpoint", "Farpoint", "Total DoF")
    
    dof_values <- get_nicer_dof_values(convertto = input$conversion, list = dof_values)

    results <- data.frame(rownames, dof_values, input$conversion)
    return(results)
  },colnames = FALSE)
})
