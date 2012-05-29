class MarketsController < ApplicationController
  def index
    if params[:lat] && params[:long]
      @markets = Market.geo_near(:lat => params[:lat], :lng => params[:lng])
    end
    
    @markets ||= Market.all
    
    @markets = @markets.limit(10)
  end

  def show
  end
end
