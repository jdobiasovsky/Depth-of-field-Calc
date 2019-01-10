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
                radioButtons("sensorsize", h3("Select sensor size"),
                             choices = list("Full Frame" = "full frame", "APS-C" = "APS-C")),
                numericInput("focal", 
                             h3("Lens focal length (mm)"), 
                             value = 17),
                numericInput("aperture", 
                             h3("Aperture value"), 
                             value = 5.6),
                numericInput("dist", 
                             h3("Distance to subject (m)"), 
                             value = 1)
                ),
              mainPanel(
                p(textOutput('sensormessage')),
                renderTable("dofresults")
              )
            )
        ))
