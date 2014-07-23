source("helpers.R")

shinyServer(function(input, output){
    output$intervallPlot <- renderPlot({
    Significance.Level <- (100 - input$Significance.Level)/100
    Standard.Deviation <- sqrt(input$Standard.Deviation)
    Number.of.Observation <- input$Number.of.Observation
    Number.of.Intervalls <- input$Number.of.Intervalls
    act <- input$action
                        
    Ausreisser <- sim.int(Number.of.Observation = Number.of.Observation, alpha = 0.2,
                    beta = 0.13, Significance.Level = Significance.Level, 
                    Standard.Deviation = Standard.Deviation,
                    Number.of.Intervalls = Number.of.Intervalls, act = act)
    text(-0.5, 1.12, paste("Stichproben:", Number.of.Intervalls), cex = 1.2)
    text(-0.5, 1.08, paste("Ausrei\u00DFer:", Ausreisser), col = "red", cex = 1.2)
    text(-0.563, 1.04, paste("Anteil der Ausrei\u00DFer:",
        round(Ausreisser/Number.of.Intervalls, 2)), cex = 1.2)
                        
    output$downloadPlot <- downloadHandler(
    filename = function() { paste("intervall", '.jpg', sep = '') },
    content = function(file) {
                jpeg(file,width = 1000, height = 600)
                print(sim.int(Number.of.Observation = Number.of.Observation, alpha = 0.2,
                    beta = 0.13, Significance.Level = Significance.Level, 
                    Standard.Deviation = Standard.Deviation,
                    Number.of.Intervalls = Number.of.Intervalls, act = act)) 
                    text(-0.5, 1.12, paste("Stichproben:", Number.of.Intervalls), cex = 1.2)
                    text(-0.5, 1.08, paste("Ausrei\u00DFer:", Ausreisser), col = "red", cex = 1.2)
                    text(-0.563, 1.04, paste("Anteil der Ausrei\u00DFer:",
                    round(Ausreisser/Number.of.Intervalls, 2)), cex = 1.2)
                dev.off()
            })
                        
                
        })
    }
)

