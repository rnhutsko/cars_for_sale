class CarsforSale::Car
  attr_accessor :year, :make, :model, :engine, :transmission, :ext_color, :price, :vdp_url, :dealer_name, :dealer_address, :dealer_phone, :type

   def self.used
    
    #do stuff to scrape cars from Cars.com 

    #stubout
      #car = self.new
      #car.type = "Used"
      #car.year = "2014"
      #car.make = "Ferrari"
      #car.model = "LaFerrari Base"
      car.price = "$4,400,000 "
      car.ext_color = "Red"
      car.engine = "6.3L V12 48V GDI DOHC Hybrid"  
      car.transmission = "7-Speed Automatic with Auto-Shift"
      #car.vdp_url = "https://www.cars.com/vehicledetail/detail/664236376/overview" 
      car.dealer_name = "Fusion Luxury Motors" 
      car.dealer_address = "20837 Nordhoff St, Los Angeles, CA"
      car.dealer_phone = "(866) 949-9665"

    


    cars_array
   end


  def self.scrape_srp
cars_array = []
    doc = Nokogiri::HTML(open("http://www.hallauto.com/used-inventory/index.htm"))
     # binding.pry
    doc.css("li.inv-type-used").each do |vehicle|
      car = self.new
      car.year = vehicle.css('div.hproduct').attr('data-year').value
      car.type = vehicle.css('div.hproduct').attr('data-classification').value
      car.make = vehicle.css('div.hproduct').attr('data-make').value
      car.model = vehicle.css('div.hproduct').attr('data-model').value
      car.year = vehicle.css('div.hproduct').attr('data-year').value
      car.vdp_url = vehicle.css("div.media a").attr('href').value
      car.price = vehicle.css("div.pricing-area.has-buttons  ul  li span  span.value").text

      cars_array << car
    end

cars_array
  end

 

end #of class

# (Attr:0x3fe292892a74 { name = "class", value = "hproduct auto mercury" }),
#         (Attr:0x3fe292892a60 { name = "data-classification", value = "wholesale" }),
#         (Attr:0x3fe292892a38 { name = "data-bodystyle", value = "Sedan" }),
#         (Attr:0x3fe2928929ac { name = "data-trim", value = "LS" }),
#         (Attr:0x3fe292892830 { name = "data-year", value = "2003" }),
#         (Attr:0x3fe29289281c { name = "data-model", value = "Grand Marquis" }),
#         (Attr:0x3fe292892678 { name = "data-vin", value = "2MEFM75W73X643356" }),
#         (Attr:0x3fe292892650 { name = "data-make", value = "Mercury" })],
#  #compareForm > div > div.bd > ul:nth-child(1) > li:nth-child(1) > div.hproduct.auto.mercury >

# div > div.pricing-area.has-buttons > ul > li:nth-child(3) > span > span.value







