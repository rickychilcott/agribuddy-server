object @market
attributes :id, :name, :street, :city, :county, :state, :zip, :description, :credit_card, :wic, :wic_cash, :sfmnp, :snap

node(:lat) { |market| market.location[:lat] }
node(:long) { |market| market.location[:lng] }