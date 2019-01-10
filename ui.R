#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
          # Application title
            titlePanel("Depth of Field Calculator"),
            
          # Sidebar with a slider input for number of bins 
            sidebarLayout(
              sidebarPanel(
                radioButtons("sensorsize", p(strong("Select sensor size: ")),
                             choices = list("Full Frame" = "full frame", "APS-C" = "APS-C")),
                numericInput("focal_len", p(strong("Focal length (mm)")), 
                             value = 17),
                numericInput("aperture", p(strong("Aperture value")),
                             value = 5.6),
                numericInput("dist", p(strong("Distance to subject (m)")), 
                             value = 1),
                radioButtons("conversion", p(strong("Display results in: ")),
                             choices = list("Meters" = "m", "Centimeters" = "cm"))),
              
              mainPanel(
                strong(textOutput("sensor_message")),
                p(textOutput('hyperfocal_message')),
                tableOutput("dof_results")))))