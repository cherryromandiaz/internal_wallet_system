class StocksController < ApplicationController
  def price
    stock_symbol = params[:symbol]
    stock_service = LatestStockPrice.new
    stock_data = stock_service.price(stock_symbol)

    if stock_data
      render json: JSON.pretty_generate(stock_data)
    else
      render json: { error: 'Stock not found' }, status: :not_found
    end
  end

  def prices
    stock_symbols = params[:symbols] # Expecting 'symbols' as a query parameter
    stock_symbols_array = stock_symbols.split(',') # Split by comma

    stock_service = LatestStockPrice.new
    stock_data = stock_service.prices(stock_symbols_array)

    render json: JSON.pretty_generate(stock_data)
  end

  def price_all
    stock_service = LatestStockPrice.new
    stock_data = stock_service.price_all
    render json: JSON.pretty_generate(stock_data)
  end
end
