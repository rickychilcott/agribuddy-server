class Market
  include Mongoid::Document
  include Mongoid::Spacial::Document
  
  field :fmid,        type: Integer
  field :name
  field :website
  
  field :street
  field :city
  field :county
  field :state
  field :zip
  
  field :location,    type: Array,  spacial: true
  field :description
  
  field :credit_card, type: Boolean   # Credit cards accepted
  field :wic,         type: Boolean   # WIC Farmers Market Nutrition Program (WIC-FMNP)
  field :wic_cash,    type: Boolean   # WIC Cash Value Vouchers
  field :sfmnp,       type: Boolean   # Senior Farmers Markets Nutrition Program (SFMNP) 
  field :snap,        type: Boolean   # Supplemental Nutrition Assistance Program (SNAP)
  
  field :baked_goods, type: Boolean   # Baked goods
  field :cheese,      type: Boolean   # Cheese and/or dairy products
  field :crafts,      type: Boolean   # Crafts and/or woodworking items
  field :flowers,     type: Boolean   # Cut flowers
  field :seafood,     type: Boolean   # Fish and/or seafood
  field :fruit,       type: Boolean   # Fresh fruit
  field :herbs,       type: Boolean   # Fresh and/or dried herbs
  field :vegetables,  type: Boolean   # Fresh vegetables
  field :honey,       type: Boolean   # Honey
  field :jams,        type: Boolean   # Jams, jellies, and preserves
  field :maple,       type: Boolean   #  Maple syrup and/or maple products	
  field :meat,        type: Boolean   # Meat and/or poultry products
  field :nuts,        type: Boolean   # Nuts
  field :plants,      type: Boolean   # Plants
  field :prepared,    type: Boolean   # Prepared foods (for immediate consumption)
  field :soap,        type: Boolean   # Soap and/or body care products
  
  validates_uniqueness_of :fmid
  validates_presence_of   :fmid
  
  validates_presence_of   :name
  
  spacial_index :location
end
