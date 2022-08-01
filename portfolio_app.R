##### Portfolio tracker
#### Packages
library(bslib)
library(coinmarketcapr)
library(dplyr)
library(shiny)
library(DT)
library(shinyWidgets)
library(tidyquant)

#### Source
source("global.R", local = T)






#### Shiny
### UI
ui <- fluidPage(
  
  ## Theme
  theme = bs_theme(version = 4, bootswatch = "minty"),
  
  
  ## Crypto - symbol dropdown
  pickerInput(
    inputId = "dropdownCryptoSymbol",
    label = "Crypto Symbol:",
    choices = df$symbol,
    multiple = T,
    options = list(
    `actions-box` = TRUE,
    `none-selected-text` = "Select Your Crypto",
    `select-all-text` = "Select All",
    `deselect-all-text` = "Deselect All"
  )
  ),
  
  
  ## Stock - ticker dropdown
  pickerInput(
    inputId = "dropdownStockTicker",
    label = "Stock Ticker:",
    choices = tickers,
    multiple = T,
    options = list(
      `actions-box` = TRUE,
      `none-selected-text` = "Select Your Stock",
      `select-all-text` = "Select All",
      `deselect-all-text` = "Deselect All"
    )
  ),
  
  
  ## Add button
  # Crypto
  actionButton("addButton", "Add Crypto"),
  
  # Stock
  actionButton("addStockButton", "Add Stock"),
  
  
  ## Table
  DT::dataTableOutput("table1"),
  DT::dataTableOutput("table_stock")
  
)
      


### Server
server <- function(input, output, session) {
  
  ### Crypto
  output$table1 <- DT::renderDataTable(data())
  
  data <- eventReactive(input$addButton, {
    req(input$dropdownCryptoSymbol)
    
    data.frame(
      "Name" = df %>% 
        filter(symbol == input$dropdownCryptoSymbol) %>% 
        select(name) %>%
        pull(),
      
      "Symbol" = df %>% 
        filter(symbol == input$dropdownCryptoSymbol) %>% 
        select(symbol) %>%
        pull(),
        
      "USD Price" = df %>% 
        filter(symbol == input$dropdownCryptoSymbol) %>% 
        mutate(usd_price = round(USD_price, 2)) %>% 
        select(usd_price) %>% 
        pull()
      
      ## to-do: add new column: numeric input from user (avg cost)
      )
  })
  
  
  
  ### Stock
  stock_data <- eventReactive(input$addStockButton, {
    req(input$dropdownStockTicker)

    data.frame(
      "Company" = getQuote(input$dropdownStockTicker) %>% 
        select(Last) %>%
        pull(),
      
      "USD Price" = getQuote(input$dropdownStockTicker) %>% 
        select(Last) %>%
        pull()
      

      ## to-do: add new column: numeric input from user (avg cost)
      )
  })

  output$table_stock <- DT::renderDataTable(stock_data())
}

shinyApp(ui, server)

