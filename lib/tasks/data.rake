namespace :data do
    FM_DATA_XLS = "fm_data.xls"
    FM_DATA_CSV = "fm_data.csv"
    # 
    # desc "Download excel spreadsheet from USDA"
    # # task :download, :url, :location do |t, args|
    # #   require 'open-uri'
    # #   args.with_defaults  url: "http://www.ams.usda.gov/AMSv1.0/getfile\?dDocName\=STELPRDC5087258", 
    # #                       location: "#{Rails.root}/tmp/"
    # #   
    # #   File.open(args[:location] + FM_DATA, 'wb') {|file|
    # #     file.print open(args[:url]).read
    # #   }
    # # end

    desc "Import data"
    task :import => :environment do |t, args|
      args.with_defaults  location: "#{Rails.root}/tmp/"
      headers = "FMID,MarketName,Website,Street,City,County,State,Zip,x,y,Location,Credit,WIC,WICcash,SFMNP,SNAP,Bakedgoods,Cheese,Crafts,Flowers,Seafood,Fruit,Herbs,Vegetables,Honey,Jams,Maple,Meat,Nuts,Plants,Prepared,Soap"
      
      CSV.foreach((args[:location] + FM_DATA_CSV), {headers: headers, encoding: "ISO8859-1"}) do |row|
        if row["FMID"]
          m = Market.find_or_initialize_by(:fmid => row["FMID"])
          m.market_name = row["MarketName"]
          m.website = row["Website"]
          m.street = row["Street"]
          m.city = row["City"]
          m.county = row["County"]
          m.state = row["State"]
          m.zip = row["Zip"]
          m.x = row["x"]
          m.y = row["y"]
          m.location = row["Location"]
          m.credit_card = row["Credit"]
          m.wic = row["WIC"]
          m.wic_cash = row["WICcash"]
          m.sfmnp = row["SFMNP"]
          m.snap = row["SNAP"]
          m.baked_goods = row["Bakedgoods"]
          m.cheese = row["Cheese"]
          m.crafts = row["Crafts"]
          m.flowers = row["Flowers"]
          m.seafood = row["Seafood"]
          m.fruit = row["Fruit"]
          m.herbs = row["Herbs"]
          m.vegetables = row["Vegetables"]
          m.honey = row["Honey"]
          m.jams = row["Jams"]
          m.maple = row["Maple"]
          m.meat = row["Meat"]
          m.nuts = row["Nuts"]
          m.plants = row["Plants"]
          m.prepared = row["Prepared"]
          m.soap = row["Soap"]
          puts m.save
        end
      end
    end
    
    # desc "Download and then import downloaded data"
    # task :download_and_import => [:download, :import] do
    #   puts "Done!"
    # end
    # 
    # desc "Export data from markets database"
    # task :export do
    #   puts "Exporting..."
    # end      
end