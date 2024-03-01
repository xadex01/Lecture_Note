library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Livelihood Distribution"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("mean",
                  "Mean:",
                  min = 0, max = 100, value = 50),
      sliderInput("sd",
                  "Standard Deviation:",
                  min = 1, max = 50, value = 10)
    ),
    mainPanel(
      plotOutput("normalPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Generate normal distribution based on user input
  normal_dist <- reactive({
    rnorm(1000, mean = input$mean, sd = input$sd)
  })
  
  # Render the plot
  output$normalPlot <- renderPlot({
    hist(normal_dist(), breaks = 30, col = "skyblue", xlab = "Livelihood", main = "Normal Distribution")
    abline(v = mean(normal_dist()), col = "red", lwd = 2)
    legend("topright", legend = paste("Mean:", round(mean(normal_dist()), 2)), col = "red", lwd = 2, bty = "n")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
