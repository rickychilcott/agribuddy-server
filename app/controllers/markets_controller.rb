class MarketsController < ApplicationController
  def index
    if params[:lat] && params[:long]
      @markets = Market.geo_near({:lng => params[:lng], :lat => params[:lat]}, num: 10)
    end
    
    @markets ||= Market.all.limit(10)
  end

  def show
  end
end
