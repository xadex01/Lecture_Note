library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  
  titlePanel("Normal Distribution Livelihood"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("mean", "Mean:",
                  min = -100, max = 100, value = 0),
      sliderInput("sd", "Standard Deviation:",
                  min = 1, max = 50, value = 10),
      sliderInput("sample_size", "Sample Size:",
                  min = 10, max = 1000, value = 100)
    ),
    
    mainPanel(
      plotOutput("normal_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$normal_plot <- renderPlot({
    # Generate random data
    data <- rnorm(input$sample_size, mean = input$mean, sd = input$sd)
    
    # Create a histogram of the data
    ggplot() +
      geom_histogram(aes(x = data, y = ..density..), bins = 30, fill = "skyblue", color = "black") +
      geom_density(alpha = 0.2, fill = "blue") +
      geom_rug(data = data.frame(x = data), aes(x = x), sides = "b", color = "red") +
      labs(title = "Normal Distribution", x = "Value", y = "Density") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
