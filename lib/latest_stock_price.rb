require 'net/http'
require 'json'
require 'uri'

class LatestStockPrice
  BASE_URL = "https://latest-stock-price.p.rapidapi.com/equities"
  API_KEY = "95b294964bmsh8bf847ab6e30a48p1ebc9bjsnb5364031e643"

  # Fetch details for a specific stock symbol
  def price(stock_symbol)
    all_stocks = fetch_all_stocks
    stock = all_stocks.find { |s| s["Symbol"] == stock_symbol }
    format_stock_data(stock) if stock
  end

  # Fetch details for multiple stock symbols
  def prices(stock_symbols)
    all_stocks = fetch_all_stocks
    filtered_stocks = all_stocks.select { |s| stock_symbols.include?(s["Symbol"]) }
    filtered_stocks.map { |stock| format_stock_data(stock) }
  end

  # Fetch all available stock prices
  def price_all
    fetch_all_stocks.map { |stock| format_stock_data(stock) }
  end

  private

  def fetch_all_stocks
    url = URI(BASE_URL)
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = API_KEY
    request["x-rapidapi-host"] = 'latest-stock-price.p.rapidapi.com'

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    response = http.request(request)
    JSON.parse(response.body)
  end

  def format_stock_data(data)
    {
      symbol: data["Symbol"],
      name: data["Name"],
      timestamp: data["Date/Time"],
      price: data["LTP"],
      net_change: data["Net Change"],
      percent_change: data["%Chng"],
      open: data["Open"],
      high: data["High"],
      low: data["Low"],
      previous_close: data["P Close"],
      volume: data["Total Volume"],
      isin: data["ISIN"],
      nse_symbol: data["NSE Symbol"],
      high_52w: data["52Wk High"],
      low_52w: data["52Wk Low"]
    }
  end
end
