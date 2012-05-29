require 'csv'

namespace :data do
    FM_DATA_XLS = "fm_data.xls"
    FM_DATA_CSV = "fm_data.csv"
    
    desc "Download excel spreadsheet from USDA"
    task :download, :url, :location do |t, args|
      require 'open-uri'
      args.with_defaults  url: "http://www.ams.usda.gov/AMSv1.0/getfile\?dDocName\=STELPRDC5087258", 
                          location: "#{Rails.root}/tmp/"
      
      File.open(args[:location] + FM_DATA, 'wb') {|file|
        file.print open(args[:url]).read
      }
    end

    desc "Import data"
    task :import => :environment do |t, args|
      args.with_defaults  location: "#{Rails.root}/public/"
      headers = "FMID,MarketName,Website,Street,City,County,State,Zip,x,y,Location,Credit,WIC,WICcash,SFMNP,SNAP,Bakedgoods,Cheese,Crafts,Flowers,Seafood,Fruit,Herbs,Vegetables,Honey,Jams,Maple,Meat,Nuts,Plants,Prepared,Soap"
      
      attribute_key_mappings = {name: "MarketName", website: "Website", street: "Street", city: "City", county: "County", 
        state: "State", zip: "Zip", description: "Location", credit_card: "Credit", wic: "WIC", wic_cash: "WICcash", sfmnp: "SFMNP", 
        snap: "SNAP", baked_goods: "Bakedgoods", cheese: "Cheese", crafts: "Crafts", flowers: "Flowers", seafood: "Seafood", 
        fruit: "Fruit", herbs: "Herbs", vegetables: "Vegetables", honey: "Honey", jams: "Jams", maple: "Maple", meat: "Meat", 
        nuts: "Nuts", plants: "Plants", prepared: "Prepared", soap: "Soap"}
       
      CSV.foreach((args[:location] + FM_DATA_CSV), {headers: headers, encoding: "ISO8859-1"}) do |row|
        if row["FMID"]
          market = Market.find_or_initialize_by(:fmid => row["FMID"])
          
          # Spacial aware long/lat
          market.location = {:long => row["x"], :lat => row["y"]}
          
          attribute_key_mappings.each do |market_key, row_key|
            # Data clean up for Y/N
            row[row_key] = true if row[row_key] == "Y"
            row[row_key] = false if row[row_key] == "N"
            
            market[market_key] = row[row_key]
          end
          
          market.save
        end
      end
    end    
end