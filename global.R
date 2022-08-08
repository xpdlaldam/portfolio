#### Stock
stock_name_symbol <- stockSymbols() %>%
  select(c("Name", "Symbol"))

tickers <- stock_name_symbol %>%
  select("Symbol") %>%
  pull()

company_names <- stock_name_symbol %>%
  select("Name") %>%
  pull()


#### Crypto
### Configuration (keys)
setup(api_key = Sys.getenv("YOUR_API_KEY")) # add the following line to your HOME directory's .Renviron file: 
# file.edit("~/.Renviron")
# YOUR_API="your_key"
# Check with: Sys.getenv()

### Data - static
df <- get_crypto_listings() 


