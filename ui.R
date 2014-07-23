library(shiny)

shinyUI(fluidPage(withMathJax(),
    titlePanel(span("Intervallschätzer", style="color:white"),
               windowTitle="Intervallschätzer"),
        
    sidebarLayout(position="right",
        sidebarPanel(
        wellPanel(style = "background-color: #FFFFFF;", h5("Bedienfenster"),
        sliderInput('Significance.Level', 'Signifikanzniveau (%)', value=5, min=0,max=50, step=1,),
        sliderInput('Standard.Deviation', 'Varianz der Störgrößen \\( ({\\sigma}^2) \\)', value=10, min=0,max=100, step=1,),
        sliderInput('Number.of.Observation', 'Beobachtungsumfang \\( (T) \\)', value=10, min=3 , max=1000, step=1,),
        sliderInput('Number.of.Intervalls', 'Stichproben \\( (S) \\)', value=100, min=1, max=100, step=1,),
        br(),
        br(),
        shinysky::actionButton('action', 'Stichprobenerzeugung', styleclass='success'),
        downloadButton('downloadPlot', 'Grafik herunterladen')),
        tags$head(
            tags$style(type="text/css", ".jslider { max-width: 300px; }")
            ),
                              
        br(), 
        br(),
        br(),
        br(),
        wellPanel(p(strong("Redaktion"), style='margin-bottom:1px;color:black;'),
            HTML("<p style='margin-bottom:1px;color:black;'>Programmierung: Andranik Stepanyan</p>"),
            p("Text: Ludwig von Auer", style="color:black"),
            HTML("<a , style='margin-bottom:1px;color:black;' href = 'https://www.uni-trier.de/index.php?id=50126' target='_blank'>Professur für Finanzwissenschaft</a>"),
            p("Fachbereich IV - Volkswirtschaftslehre", style = 'margin-bottom:1px;color:black;'),
            p("Universität Trier", style="color:black"),
            p(strong("Lehrbuch"), style = 'margin-bottom:1px; color:black;'),
            HTML("<p style = 'color:black;'>Auer, Ludwig <a href = 'https://www.uni-trier.de/index.php?id=15929' target='_blank'><img src='buch.jpg' style='float: right;'></a>von (2013),
                <a href = 'https://www.uni-trier.de/index.php?id=15929' target='_blank' style='color:black'>Ökonometrie - eine Einführung,<br>
                6. Auflage, Springer-Gabler<a/> </p>"),
                              					
        br(),
        br(),
        HTML('<div class="btn-group dropup">
            <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#">
            Weitere Animationen
            <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
            <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/Stoergroessen/" target="_blank">&nbsp; Störgrößen</a></p>
            <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/WiederholteStichproben/" target="_blank">&nbsp; KQ-Schätzer</a></p>
            <p style="margin-bottom:1px;color:black;">&nbsp; Intervallschätzer</a>
            <p style="margin-bottom:1px;" ><a href="https://oekonometrie.shinyapps.io/t-Test/" target="_blank">&nbsp; t-Test</a></p>
            <p style="margin-bottom:1px;"><a href="https://oekonometrie.shinyapps.io/Ftest/" target="_blank">&nbsp; F-Test vs t-Test</a></p>
                              							 
            </ul>
            </div>')),
        list(tags$head(tags$style("body {background-color: #6d6d6d; }")))
                      
                                  
                            
        ),
        mainPanel(
             wellPanel(wellPanel(style = "background-color: #FFFFFF;",
                        plotOutput("intervallPlot", height="600px"))),
                            
            wellPanel(style = "background-color: #DEEBF7;", tabsetPanel(type = "pills",
                        tabPanel(h5("Was wird veranschaulicht?"),
                                                   
    p("Bei jeder wiederholten Stichprobe berechnet der Intervallschätzer
      für den Steigungsparameter \\( \\beta \\) ein neues Intervall.
      In der Animation können Sie den Einfluss des Signifikanzniveaus,
      der Störgrößenvarianz und des Beobachtungsumfangs auf die Gestalt
      der erzeugten Intervalle studieren.", style="color:black") ), 
    
        tabPanel(h5("Was zeigt die Anfangseinstellung?"),
    p("Die Animation greift das Trinkgeld-Beispiel des Lehrbuches auf. Für
    jeden Gast t wird das beobachtete Trinkgeld \\( y_{t} \\) durch den 
    Rechnungsbetrag \\( x_{t} \\) erklärt: $$y_{t}=α+βx_{t}+u_{t}$$ 
    Die Animation basiert auf dem Parameterwert \\( \\beta =0,13 \\). In der
    Anfangseinstellung sind die Rechungsbeträge \\(x_{1}=10 \\), \\( x_{2}=30 \\)
    und \\( x_{3}=50 \\) zugrunde gelegt .
    Ferner wurden normalverteilte Störgrößen \\( u_{t} \\) mit Erwartungswert
    \\( E(u_{t})=0 \\) unterstellt. Die Störgrößenvarianz beträgt \\(
    {\\sigma}^2 = 2 \\), das Siginifikanzniveau \\( a=5\\% \\) und der 
    Beobachtungsumfang (Anzahl der Beobachtungen pro Stichprobe) \\( T=3 \\).
    Es werden \\( S=100 \\) Stichproben (berechnete Intervalle) erzeugt. Jedes
    Intervall wird dabei mit der Formel 
    $$[\\hat{\\beta}-t_{0,025}⋅\\widehat{sd}(\\hat{\\beta}),\\hat{\\beta}+t_{0,025}⋅\\widehat{sd}(\\hat{\\beta})]$$ 
    berechnet, wobei \\( \\hat{\\beta} \\) der KQ-Schätzwert ist und \\(
    \\widehat{sd}(\\hat{\\beta}) \\) seine Standardabweichung angibt. Für den
    Wert \\( t_{0,025} \\) gilt, dass eine \\( t \\)-verteilte Zufallsvariable
    mit \\( T-2 \\) Freiheitsgraden mit einer Wahrscheinlichkeit von
    \\( 2,5\\% \\) größer oder gleich diesem
    Wert ausfällt.", HTML("<p style='color:black;'>Die Grafik zeigt die
    erzeugten Intervalle und
    den Parameterwert \\( \\beta =0,13 \\). Die schwarzen Intervalle
    überdecken diesen Wert, die roten hingegen nicht. Die Anzahl und der
    Anteil der roten Intervalle ist links oben in der Grafik
    angezeigt.</p>"), style="color:black")),
    
        tabPanel(h5("Benutzungshinweise"), 
    p(HTML('<p style="color:black;">Im Bedienfenster sehen Sie verschiedene
    Schieber <img src="slider.jpg">,
    mit denen Sie die der Intervallberechnung zugrunde
    liegenden Parameterwerte verändern können. Klicken Sie dafür mit der
    linken Maustaste auf den entsprechenden Schieber und bewegen sie ihn nach
    rechts oder links.</p>'), HTML('<ul><li style="color:black;">Bei unendlich 
    oft wiederholten
    Stichproben wird ein bestimmter Prozentsatz der berechneten Intervalle den
    wahren Wert \\( \\beta =0,13 \\) <em>nicht</em> abdecken. Mit dem
    <strong>Signifikanzniveau-Schieber</strong> stellen Sie ein, wie groß
    dieser Prozentsatz sein soll. Wenn Sie den Prozentsatz erhöhen, werden die
    berechneten Intervalle schmaler und die Anzahl sowie der Anteil der rot
    markierten Intervalle (in der Grafik als "Ausreißer" bezeichnet) erhöhen
    sich.</li></ul>'),
      HTML('<ul><li style="color:black;"> Der <strong>Störgrößenvarianz-Schieber
    </strong> legt
    fest, wie stark die Störgrößen \\( u_{t} \\) streuen. Wenn Sie die
    Varianz erhöhen, sinkt die Genauigkeit der KQ-Schätzung und die Breite
    der berechneten Intervalle steigt.</li></ul>'), 
    HTML('<ul><li style="color:black;">Der
    <strong>Beobachtungsumfang-Schieber</strong> gibt an, wie viel 
    Beobachtungen pro Stichprobe vorliegen. Eine Erhöhung des 
    Beobachtungsumfangs erhöht die Genauigkeit der KQ-Schätzung und schlägt 
    sich in engeren Intervallen nieder. </li></ul>'), 
    HTML('<ul><li style="color:black;">Mit dem
    <strong>Stichproben-Schieber</strong> legen Sie fest, wie viel 
    wiederholte Stichproben \\( S \\) und damit wie viel Intervalle erzeugt
    werden sollen. </li></ul>'),
    HTML('<ul><li style="color:black;">Wenn Sie den Knopf <img src="stich.jpg">
    drücken, werden \\( S \\) neue Stichproben und
    damit Intervalle erzeugt und die alten werden gelöscht.</li></ul>'),
    HTML('<ul><li style="color:black;">Um die aktuelle Grafik in einer 
    jpg-Datei zu speichern,
    klicken Sie das Feld <img src="download.jpg"> an.</li></ul>'),
    HTML("<p style='color:black;'>Um Animationen zu anderen ökonometrischen
    Themen zu sehen,
    klicken Sie bitte auf <img src = 'info.jpg'>.</p>")
      

    )),
    tabPanel(h5("Details"), 
    				 p(HTML("<p
style='color:black;'> Die Animation ist mit dem statistischen
Programm R erzeugt worden. Die entsprechenden R-Skripte für die Reproduktion dieser
Seite sind unter folgendem Link aufrufbar:
<a href='https://github.com/andronikoss/Intervallschaetzer' target='_blank'>R
Codes.</a></p>"))),
    
    
    
                     br(),
                     br(),
                     br()


                 
                              
                              
        ))
    )
)))      















