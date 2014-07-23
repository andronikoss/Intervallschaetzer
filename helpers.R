
# Intervall - Generator (gedanklich wiederholte Stichproben)
sim.int <- function(Number.of.Observation, alpha, beta, Number.of.Intervalls, Significance.Level,
                    exp.u = 0, Standard.Deviation, act = act){
        
        # Parameteranpssungen
        par(mar = c(5.1, 4.1, 4.1, 2.1), mgp = c(4, 2, 0) )
        
        # Signifikanzniveau bei 100 Prozent
        if(Significance.Level == 1){
            Significance.Level <- 0.999999999998
        }
        set.seed(16)
        # Nur positive x-Werte werden definiert.
        repeat {
            x <- rnorm(Number.of.Observation, 45, 18)
            if ((length(which(x < 0))) == 0){break}
        }
        # Simulation
        set.seed(17 + act)
        M <- matrix(NA, Number.of.Intervalls,  2)
        for (i in 1:Number.of.Intervalls){
                k <- rep(1, Number.of.Intervalls)
                y <- alpha + beta * x + rnorm(k[i] * Number.of.Observation, exp.u, Standard.Deviation)
                ols <- lm(y ~ x)
                M[i, 1:2] <- confint(ols, level = Significance.Level)[2,]
        }
        a <- seq(0.03, 1, length=Number.of.Intervalls)
        b <- cbind(M, a, a)
        # Intervall-Funktion wird definiert
        intervall <- function(coords,...){
                lines(coords[1:2], coords[3:4], lty = 1, lwd = 1.4, ...)
        }
        plot(-1:1, seq(0, 1.15, length.out = 3), type = "n",
             xlab = "", ylab = "Intervalle", axes = F,
             main = "Berechnete Intervalle"
             #expression(hat(beta))
        )
        par(mar = c(5.1, 4.1, 4.1, 2.1), mgp = c(4, 1.5, 0) )
        axis(1, at = beta, labels = expression(paste(beta, " = 0.13")),
             tcl = -0.25, padj = -0.7, cex.axis = 1.3)
        axis(1, at = beta, labels = expression(paste(beta, " = 0.13")),
             tcl = -0.25, padj = -0.7, cex.axis = 1.3)
      
        par(mar = c(5.1, 4.1, 4.1, 2.1), mgp = c(4, 2.3, 0) )
        axis(1, tcl = -0.25, padj = -0.7, cex.axis = 1.3)

        apply(b, 1, intervall)
        box()
        abline(v = beta, lty = 2)
        
        # Markierung der Stichproben, die den wahren Wert von beta
        # nicht abdecken.
        
        links <- which( (beta > M[,1]) == 0 )  # rechtsverschobene Intervalle
        rechts <- which( (beta > M[,2]) == 1 ) # linksverschobene Intervalle
        if(length(c(links, rechts)) != 0){
            all <- c(links, rechts)    
            Ausreisser <- length(all)
            #        text(1.1, 0.85, paste("Ausrei?er: ", Ausreisser), cex=0.7, col="red")
            #        text(1.1, 0.9, paste("Insgesamt: ", Number.of.Intervalls), cex=0.7)
            P <- b[c(links, rechts), , drop = F]
            for(j in 1:nrow(P)) {
                intervall(P[j, ], col = "red")
            }
        } else {
            Ausreisser <- 0
            apply(b, 1, intervall)
        }
        return(Ausreisser)
        
}
