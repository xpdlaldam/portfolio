#### Stock
### Grab all names & tickers - static
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
# Sys.setenv("YOUR_VAR_NAME"="YOUR_API")
setup(api_key = Sys.getenv("keyid"))



### Data - static
df <- get_crypto_listings() %>% head(10)

